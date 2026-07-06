import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Tracks which courses the learner has added to their Wishlist / My
/// Courses list, persisted on-device.
class WishlistService extends ChangeNotifier {
  static const _storageKey = 'wishlist_course_ids_v1';
  final Set<String> _courseIds = {};

  Set<String> get courseIds => _courseIds;

  bool isWishlisted(String courseId) => _courseIds.contains(courseId);

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_storageKey);
    if (raw == null) return;
    final List list = jsonDecode(raw);
    _courseIds
      ..clear()
      ..addAll(list.cast<String>());
    notifyListeners();
  }

  Future<void> toggle(String courseId) async {
    if (_courseIds.contains(courseId)) {
      _courseIds.remove(courseId);
    } else {
      _courseIds.add(courseId);
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_courseIds.toList()));
  }

  Future<void> add(String courseId) async {
    if (_courseIds.contains(courseId)) return;
    _courseIds.add(courseId);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonEncode(_courseIds.toList()));
  }
}
