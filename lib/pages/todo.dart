import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_db/functions/theme_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:todo_db/pages/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userToDo;
  List<String> todoList = [];

  void saveList(List<String> todoList) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setStringList('todo', todoList);
  }

  Future<void> getList() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      List<String> todo = prefs.getStringList('todo') ?? [];
      todoList = todo;
    });
  }

  void removeTask(int index) {
    setState(() {
      todoList.removeAt(index);
      saveList(todoList);
    });
  }

  Route _settingsRoute(BuildContext context) {
    return MaterialPageRoute(
      builder: (context) {
        return Settings();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    getList();
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return Scaffold(
          backgroundColor: themeProvider.currentTheme.scaffoldBackgroundColor,
          appBar: AppBar(
            actions: [
              IconButton(
                icon: Icon(Icons.settings, color: Colors.lightBlueAccent),
                onPressed: () {
                  Navigator.push(context, _settingsRoute(context));
                },
              ),
            ],
            backgroundColor:themeProvider.currentTheme.appBarTheme?.backgroundColor,
            bottomOpacity: 0.0,
            elevation: 0.0,
            title: const Text('Список дел',
                style: TextStyle(color: Colors.lightBlueAccent)),
            centerTitle: true,
          ),
          body: ListView.builder(
            itemCount: todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return Dismissible(
                key: Key(todoList[index]),
                child: Card(
                  color: Colors.lightBlueAccent,
                  child: ListTile(
                    title: Text(
                      todoList[index],
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ),
                    trailing: IconButton(
                      icon: const Icon(
                        Icons.delete_sweep,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        removeTask(index);
                      },
                    ),
                  ),
                ),
                onDismissed: (direction) {
                  removeTask(index);
                },
              );
            },
          ),
          floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.lightBlueAccent,
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    backgroundColor: themeProvider.currentTheme.backgroundColor,
                    title: const Text('Добавить задачу'),
                    content: TextField(
                      onChanged: (String value) {
                        _userToDo = value;
                      },
                    ),
                    actions: [
                      ElevatedButton(
                        onPressed: () {
                          setState(() {
                            todoList.add(_userToDo);
                            saveList(todoList);
                          });
                          Navigator.of(context).pop();
                        },
                        child: Text(
                          'Добавить',
                          style: TextStyle(color: Colors.white),
                        ),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            Colors.lightBlueAccent,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.add, size: 30.0, color: Colors.white),
          ),
        );
      },
    );
  }
}
