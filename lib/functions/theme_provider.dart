import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider with ChangeNotifier {

final Color _dropdownBackgroundColorLight = Colors.white;
final Color _dropdownTextColorLight = Colors.lightBlueAccent;
final Color _dropdownBackgroundColorLightEnabled = Colors.white;
final Color _dropdownTextColorLightEnabled = Colors.lightBlueAccent;

final Color _dropdownBackgroundColorDark = Colors.orangeAccent;
final Color _dropdownTextColorDark = Colors.black;
final Color _dropdownBackgroundColorDarkEnabled = Colors.black;
final Color _dropdownTextColorDarkEnabled = Colors.orangeAccent;

  Color get dropdownBackgroundColor =>
      _isDarkThemeEnabled ? _dropdownBackgroundColorDark : _dropdownBackgroundColorLight;

  Color get dropdownTextColor =>
      _isDarkThemeEnabled ? _dropdownTextColorDark : _dropdownTextColorLight;

  Color get dropdownBackgroundColorEnabled =>
      _isDarkThemeEnabled ? _dropdownBackgroundColorDarkEnabled : _dropdownBackgroundColorLightEnabled;

  Color get dropdownTextColorEnabled =>
      _isDarkThemeEnabled ? _dropdownTextColorDarkEnabled : _dropdownTextColorLightEnabled;

  bool _isDarkThemeEnabled = false;
  String _selectedLanguage = 'Русский';
  final List<String> _languages = ['Русский', 'English'];

  bool get isDarkThemeEnabled => _isDarkThemeEnabled;
  String get selectedLanguage => _selectedLanguage;
  List<String> get languages => _languages;

  static const String _darkThemeKey = 'darkTheme';
  static const String _selectedLanguageKey = 'selectedLanguage';

  // Light Theme Colors
static final ThemeData _lightTheme = ThemeData(
  primaryColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  appBarTheme: const AppBarTheme(
    color: Colors.white,
    iconTheme: const IconThemeData(
      color: Colors.lightBlueAccent,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.white,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.white),
    bodyText2: TextStyle(color: Colors.lightBlueAccent),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.lightBlueAccent,
    foregroundColor: Colors.white,
  ),
  iconTheme: const IconThemeData(
    color: Colors.white,
  ),
  cardColor: Colors.lightBlueAccent,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent.withOpacity(0.5)),
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.lightBlueAccent.withOpacity(0.5);
        }
        return Colors.lightBlueAccent;
      },
    ),
    overlayColor: MaterialStateProperty.all<Color>(Colors.lightBlueAccent.withOpacity(0.2)),
  ),
);

  // Dark Theme Colors
static final ThemeData _darkTheme = ThemeData.dark().copyWith(
  primaryColor: Colors.black,
  scaffoldBackgroundColor: Colors.black,
  appBarTheme: const AppBarTheme(
    color: Colors.black,
    iconTheme: const IconThemeData(
      color: Colors.orange,
    ),
    actionsIconTheme: const IconThemeData(
      color: Colors.orange,
    ),
  ),
  textTheme: const TextTheme(
    bodyText1: TextStyle(color: Colors.black),
    bodyText2: TextStyle(color: Colors.orangeAccent),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.orangeAccent,
    foregroundColor: Colors.black,
  ),
  iconTheme: const IconThemeData(
    color: Colors.black,
  ),
  cardColor: Colors.orangeAccent,
  switchTheme: SwitchThemeData(
    trackColor: MaterialStateProperty.all<Color>(Colors.orangeAccent.withOpacity(0.5)),
    thumbColor: MaterialStateProperty.resolveWith<Color>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.disabled)) {
          return Colors.orangeAccent.withOpacity(0.5);
        }
        return Colors.orangeAccent;
      },
    ),
    overlayColor: MaterialStateProperty.all<Color>(Colors.orangeAccent.withOpacity(0.2)),
  ),
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


