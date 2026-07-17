import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLocaleController extends ChangeNotifier {
  AppLocaleController._();

  static final AppLocaleController instance = AppLocaleController._();

  static const String _localeKey = 'selected_app_locale';

  Locale? _locale;

  Locale? get locale => _locale;

  Future<void> load() async {
    final preferences = await SharedPreferences.getInstance();
    final savedCode = preferences.getString(_localeKey);

    if (savedCode != null && savedCode.isNotEmpty) {
      _locale = Locale(savedCode);
    }
  }

  Future<void> setLocale(String? languageCode) async {
    final preferences = await SharedPreferences.getInstance();

    if (languageCode == null) {
      _locale = null;
      await preferences.remove(_localeKey);
    } else {
      _locale = Locale(languageCode);
      await preferences.setString(_localeKey, languageCode);
    }

    notifyListeners();
  }
}
