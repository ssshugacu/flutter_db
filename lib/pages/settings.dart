import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db/functions/theme_provider.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Provider.of<ThemeProvider>(context).currentTheme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: Provider.of<ThemeProvider>(context).currentTheme.appBarTheme.backgroundColor,
        bottomOpacity: 0.0,
        elevation: 0.0,
        title: Text('Настройки',style: TextStyle(color: Provider.of<ThemeProvider>(context).currentTheme.textTheme.bodyText2?.color),
),

        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Provider.of<ThemeProvider>(context).currentTheme.appBarTheme.iconTheme?.color),
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
                title: Text('Темная тема', style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText2?.color)),
                trailing: 
                Switch(value: themeProvider.isDarkThemeEnabled,
                onChanged: (value) {
                themeProvider.toggleTheme();
                  },
                activeTrackColor: themeProvider.currentTheme.switchTheme.trackColor?.resolve({MaterialState.selected}),
                activeColor: themeProvider.currentTheme.switchTheme.thumbColor?.resolve({MaterialState.selected}),
                inactiveTrackColor: themeProvider.currentTheme.switchTheme.trackColor?.resolve({}),
                inactiveThumbColor: themeProvider.currentTheme.switchTheme.thumbColor?.resolve({}))
              ),
              ListTile(
                title: Text('Язык', style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText2?.color)),
                trailing: DropdownButton(
  value: themeProvider.selectedLanguage,
  items: themeProvider.languages.map((String language) {
    return DropdownMenuItem(
      value: language,
      child: Text(
        language,
        style: TextStyle(
          color: themeProvider.dropdownTextColorEnabled,
        ),
      ),
    );
  }).toList(),
  onChanged: (String? value) {
    themeProvider.setSelectedLanguage(value ?? '');
  },
  dropdownColor: themeProvider.dropdownBackgroundColor,
  style: themeProvider.currentTheme.textTheme.bodyText2?.copyWith(
    color: themeProvider.dropdownTextColor,  // Цвет текста при активном состоянии
  ),
  icon: Icon(
    Icons.arrow_drop_down,
    color: themeProvider.dropdownTextColorEnabled,  // Цвет стрелочки при активном состоянии
  ),
  iconEnabledColor: themeProvider.dropdownTextColor,  // Цвет стрелочки при неактивном состоянии
),



              ),
            ],
          );
        },
      ),
    );
  }
}
