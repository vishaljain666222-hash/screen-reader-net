import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// A signed-in user's basic profile. Deliberately shaped like Firebase's
/// `User` (name/email getters) so swapping in real Firebase Auth later only
/// means changing AuthService internals, not any screen that reads
/// `auth.currentUser`.
class LocalUser {
  final String name;
  final String email;

  const LocalUser({required this.name, required this.email});

  Map<String, dynamic> toJson() => {'name': name, 'email': email};
  factory LocalUser.fromJson(Map<String, dynamic> json) =>
      LocalUser(name: json['name'] ?? '', email: json['email'] ?? '');
}

/// V1 authentication: accounts are created and checked entirely on-device
/// with SharedPreferences. This lets registration/login work immediately,
/// with no backend or Firebase project required.
///
/// UPGRADE PATH: to switch to real Firebase Auth + Google Sign-In later,
/// replace the bodies of signUp/signIn/signInWithGoogle/signOut with calls
/// into `firebase_auth` / `google_sign_in` (see the commented-out original
/// implementation in git history / README.md) — every screen in this app
/// only calls these four methods plus `currentUser` and `isLoggedIn`, so no
/// other file needs to change.
class AuthService extends ChangeNotifier {
  static const _usersKey = 'local_users_v1'; // email -> {name, passwordHash}
  static const _sessionKey = 'local_session_email_v1';

  LocalUser? _currentUser;
  LocalUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  /// Call once at startup (see main.dart) to restore any existing session.
  Future<void> restoreSession() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString(_sessionKey);
    if (email == null) return;
    final users = await _loadUsers();
    final record = users[email];
    if (record != null) {
      _currentUser = LocalUser(name: record['name'] as String, email: email);
      notifyListeners();
    }
  }

  Future<String?> signUp({
    required String name,
    required String email,
    required String password,
  }) async {
    final normalizedEmail = email.trim().toLowerCase();
    if (name.trim().isEmpty) return 'Please enter your name.';
    if (!normalizedEmail.contains('@')) return 'Please enter a valid email address.';
    if (password.length < 6) return 'Password must be at least 6 characters.';

    final users = await _loadUsers();
    if (users.containsKey(normalizedEmail)) {
      return 'An account already exists with that email. Try logging in instead.';
    }
    users[normalizedEmail] = {
      'name': name.trim(),
      'passwordHash': _hash(password),
    };
    await _saveUsers(users);
    await _startSession(normalizedEmail, name.trim());
    return null; // null = success
  }

  Future<String?> signIn({required String email, required String password}) async {
    final normalizedEmail = email.trim().toLowerCase();
    final users = await _loadUsers();
    final record = users[normalizedEmail];
    if (record == null || record['passwordHash'] != _hash(password)) {
      return 'Incorrect email or password. Please try again.';
    }
    await _startSession(normalizedEmail, record['name'] as String);
    return null;
  }

  /// Placeholder for v1 — real Google Sign-In needs a Firebase project.
  /// See README.md "Adding real Google Sign-In" for the upgrade steps.
  Future<String?> signInWithGoogle() async {
    return 'Google Sign-In is coming soon — it needs a one-time Firebase setup. '
        'Use email sign up for now.';
  }

  Future<void> sendPasswordReset(String email) async {
    // No-op in the local, offline v1 — there is no email server to send from.
    // Kept as a method so the UI code doesn't need to change once real
    // Firebase-based password reset is wired in.
    return;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_sessionKey);
    _currentUser = null;
    notifyListeners();
  }

  Future<void> _startSession(String email, String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_sessionKey, email);
    _currentUser = LocalUser(name: name, email: email);
    notifyListeners();
  }

  Future<Map<String, dynamic>> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_usersKey);
    if (raw == null) return {};
    return Map<String, dynamic>.from(jsonDecode(raw));
  }

  Future<void> _saveUsers(Map<String, dynamic> users) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_usersKey, jsonEncode(users));
  }

  String _hash(String password) => sha256.convert(utf8.encode(password)).toString();
}
