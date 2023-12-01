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

  static final ThemeData _lightTheme = ThemeData(
    primaryColor: Colors.white, // Цвет фона
    scaffoldBackgroundColor: Colors.white, 
    bottomAppBarTheme: BottomAppBarTheme(color: Colors.white),
    appBarTheme: AppBarTheme(color: Colors.white),
    // Цвет фона Scaffold
    // Добавьте другие параметры, которые вам нужны
    // Например, шрифты, размеры текста, стили текста и т. д.
  );

  static final ThemeData _darkTheme = ThemeData.dark().copyWith(
    primaryColor: Colors.black,
    scaffoldBackgroundColor: Colors.black,
    appBarTheme: AppBarTheme(color: Colors.orangeAccent),
    // В темной теме обычно нет явного установленного цвета фона
    // и тема наследует стандартные цвета для темной темы
    // Вы можете настроить дополнительные параметры, как вам нужно
    // Например, шрифты, размеры текста, стили текста и т. д.
  );

  ThemeData get currentTheme {
    return _isDarkThemeEnabled ? _darkTheme : _lightTheme;
  }

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
