import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db/functions/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  bool isDarkThemeEnabled = false; // значение для темной темы
  String selectedLanguage = 'Русский'; // Выбранный язык
  List<String> languages = ['Русский', 'English']; // Список доступных языков

  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
      bottomOpacity: 0.0,
      elevation: 0.0,
      title: const Text('Настройки', style: TextStyle(color: Colors.lightBlueAccent)),
      centerTitle: true,
      leading: IconButton(
        icon: Icon(Icons.arrow_back, color: Colors.lightBlueAccent),
        onPressed: () {
          Navigator.pop(context);
          Navigator.pushNamedAndRemoveUntil(context, '/todo', (route) => false);
        },
      ),
    ),
    body: Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return ListView(
          children: [
            ListTile(
              title: Text('Темная тема'),
              trailing: Switch(
                value: themeProvider.isDarkThemeEnabled,
                onChanged: (value) {
                  themeProvider.toggleTheme();
                },
              ),
            ),
            ListTile(
              title: Text('Язык'),
              trailing: DropdownButton(
                value: themeProvider.selectedLanguage,
                items: themeProvider.languages.map((String language) {
                  return DropdownMenuItem(
                    value: language,
                    child: Text(language),
                  );
                }).toList(),
                onChanged: (String? value) {
                  themeProvider.setSelectedLanguage(value ?? '');
                },
              ),
            ),
          ],
        );
      },
    ),
  );
}
}
