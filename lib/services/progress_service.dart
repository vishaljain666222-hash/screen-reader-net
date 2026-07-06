import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/models.dart';

/// Tracks the user's best quiz score per course + difficulty + screen
/// reader combination, persisted on-device.
class ProgressService extends ChangeNotifier {
  static const _storageKey = 'quiz_attempts_v2';
  final Map<String, QuizAttempt> _bestAttempts = {};

  Map<String, QuizAttempt> get bestAttempts => _bestAttempts;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;
    final Map<String, dynamic> decoded = jsonDecode(raw);
    _bestAttempts.clear();
    decoded.forEach((key, json) {
      _bestAttempts[key] = QuizAttempt.fromJson(json);
    });
    notifyListeners();
  }

  Future<void> recordAttempt(QuizAttempt attempt) async {
    final existing = _bestAttempts[attempt.storageKey];
    if (existing == null || attempt.score > existing.score) {
      _bestAttempts[attempt.storageKey] = attempt;
      await _save();
      notifyListeners();
    }
  }

  QuizAttempt? bestFor(String courseId, String quizKey) =>
      _bestAttempts['${courseId}__$quizKey'];

  /// Best score across all quizzes for a course, used for the course-level
  /// summary badge.
  QuizAttempt? bestOverallFor(String courseId) {
    QuizAttempt? best;
    for (final attempt in _bestAttempts.values) {
      if (attempt.courseId != courseId) continue;
      if (best == null || attempt.score / attempt.total > best.score / best.total) {
        best = attempt;
      }
    }
    return best;
  }

  Future<void> _save() async {
    final prefs = await SharedPreferences.getInstance();
    final encoded = jsonEncode(
      _bestAttempts.map((key, value) => MapEntry(key, value.toJson())),
    );
    await prefs.setString(_storageKey, encoded);
  }
}
