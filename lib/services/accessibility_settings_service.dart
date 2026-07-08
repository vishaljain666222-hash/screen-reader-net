import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Persisted accessibility preferences, per Master Plan Section 3.2/3.3:
/// adjustable text size, a High Contrast Mode, a screen-reader hints
/// toggle, and a Dark Mode / Light Mode switch.
class AccessibilitySettingsService extends ChangeNotifier {
  static const _fontScaleKey = 'a11y_font_scale_v1';
  static const _highContrastKey = 'a11y_high_contrast_v1';
  static const _hintsKey = 'a11y_hints_v1';
  static const _darkModeKey = 'a11y_dark_mode_v1';

  double _fontScale = 1.0; // 1.0 = 100%, up to 2.0 = 200% per Master Plan 3.2
  bool _highContrast = false;
  bool _screenReaderHints = true;
  bool _darkMode = false;

  double get fontScale => _fontScale;
  bool get highContrast => _highContrast;
  bool get screenReaderHints => _screenReaderHints;
  bool get darkMode => _darkMode;

  Future<void> load() async {
    final prefs = await SharedPreferences.getInstance();
    _fontScale = prefs.getDouble(_fontScaleKey) ?? 1.0;
    _highContrast = prefs.getBool(_highContrastKey) ?? false;
    _screenReaderHints = prefs.getBool(_hintsKey) ?? true;
    _darkMode = prefs.getBool(_darkModeKey) ?? false;
    notifyListeners();
  }

  Future<void> setFontScale(double scale) async {
    _fontScale = scale.clamp(1.0, 2.0);
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_fontScaleKey, _fontScale);
  }

  Future<void> setHighContrast(bool value) async {
    _highContrast = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_highContrastKey, value);
  }

  Future<void> setScreenReaderHints(bool value) async {
    _screenReaderHints = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_hintsKey, value);
  }

  Future<void> setDarkMode(bool value) async {
    _darkMode = value;
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_darkModeKey, value);
  }
}
