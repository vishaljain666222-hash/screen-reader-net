import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

/// Tracks the user's best quiz score per course, persisted on-device.
///
/// This keeps the "track your performance" requirement working even
/// before a full backend/Firestore sync is wired up. Swapping this for
/// a Firestore-backed implementation later only requires changing the
/// body of these two methods.
class ProgressService extends ChangeNotifier {
  static const _storageKey = 'quiz_attempts_v1';
  final Map<String, QuizAttempt> _bestAttempts = {};

  Map<String, QuizAttempt> get bestAttempts => _bestAttempts;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;
    final Map<String, dynamic> decoded = jsonDecode(raw);
    _bestAttempts.clear();
    decoded.forEach((courseId, json) {
      _bestAttempts[courseId] = QuizAttempt.fromJson(json);
    });
    notifyListeners();
  }

  Future<void> recordAttempt(QuizAttempt attempt) async {
    final existing = _bestAttempts[attempt.courseId];
    // Only keep the best (highest scoring) attempt per course.
    if (existing == null || attempt.score > existing.score) {
      _bestAttempts[attempt.courseId] = attempt;
      await _save();
      notifyListeners();
    }
  }

  QuizAttempt? bestFor(String courseId) => _bestAttempts[courseId];

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      _bestAttempts.map((key, value) => MapEntry(key, value.toJson())),
    );
    await prefs.setString(_storageKey, encoded);
  }
}
