import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {
  bool _isDarkThemeEnabled = false;
  String _selectedLanguage = 'Русский';
  List<String> _languages = ['Русский', 'English'];

  bool get isDarkThemeEnabled => _isDarkThemeEnabled;
  String get selectedLanguage => _selectedLanguage;
  List<String> get languages => _languages;

  // Ключи для хранения настроек в SharedPreferences
  static const String _darkThemeKey = 'darkTheme';
  static const String _selectedLanguageKey = 'selectedLanguage';

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _isDarkThemeEnabled = prefs.getBool(_darkThemeKey) ?? false;
    _selectedLanguage = prefs.getString(_selectedLanguageKey) ?? 'Русский';
    notifyListeners();
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(_darkThemeKey, _isDarkThemeEnabled);
    prefs.setString(_selectedLanguageKey, _selectedLanguage);
  }

  void toggleTheme() {
    _isDarkThemeEnabled = !_isDarkThemeEnabled;
    _saveSettings();
    notifyListeners();
  }

  void setSelectedLanguage(String language) {
    _selectedLanguage = language;
    _saveSettings();
    notifyListeners();
  }

  ThemeProvider() {
    _loadSettings();
  }
}
