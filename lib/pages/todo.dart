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
              icon: Icon(Icons.settings, color: themeProvider.currentTheme.appBarTheme.iconTheme?.color),
              onPressed: () {
                Navigator.push(context, _settingsRoute(context));
              },
            ),
          ],
          backgroundColor: themeProvider.currentTheme.appBarTheme.backgroundColor,
          bottomOpacity: 0.0,
          elevation: 0.0,
         title: Text(themeProvider.getTodoListTitle(),
             style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText2?.color)),
          centerTitle: true,
        ),
        body: ListView.builder(
  itemCount: todoList.length,
  itemBuilder: (BuildContext context, int index) {
    return Dismissible(
      key: Key(todoList[index]),
      child: Card(
        color: themeProvider.currentTheme.cardColor,
        child: ListTile(
          title: Text(todoList[index],
            style: TextStyle(fontSize: 30, color: themeProvider.currentTheme.textTheme.bodyText1?.color),
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              IconButton(
                icon: Icon(
                  Icons.delete_sweep,
                  color: themeProvider.currentTheme.iconTheme.color,
                ),
                onPressed: () {
                  removeTask(index);
                },
              ),
              IconButton(
                icon: Icon(
                  Icons.edit,
                  color: themeProvider.currentTheme.iconTheme.color,
                ),
                onPressed: () {
                  showDialog(
  context: context,
  builder: (BuildContext context) {
    String updatedTask = todoList[index];
    return AlertDialog(
  backgroundColor: themeProvider.currentTheme.floatingActionButtonTheme.backgroundColor,
  title: Text(
    themeProvider.getEditingTodoListDialog(),
    style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText1?.color),
  ),
  content: TextField(
    onChanged: (String value) {
      updatedTask = value;
    },
    controller: TextEditingController(text: todoList[index]),
    style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText1?.color), // Цвет текста в поле ввода
    cursorColor: themeProvider.currentTheme.textTheme.bodyText1?.color ?? Colors.white, // Цвет подсветки
    decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.currentTheme.textTheme.bodyText1?.color ?? Colors.white), // Цвет подсветки при фокусе
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.currentTheme.textTheme.bodyText1?.color ?? Colors.white), // Цвет подсветки в статичном положении
              ),
            ),
  ),
  actions: [
    ElevatedButton(
      onPressed: () {
        setState(() {
          todoList[index] = updatedTask;
          saveList(todoList);
        });
        Navigator.of(context).pop();
      },
      child: Text(themeProvider.getEditingTodoListButton(),
        style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText2?.color),
      ),
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(
          themeProvider.currentTheme.primaryColor,
        ),
      ),
    ),
  ],
);

  },
);

                },
              ),
            ],
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
  backgroundColor: themeProvider.currentTheme.floatingActionButtonTheme.backgroundColor,
  onPressed: () {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: themeProvider.currentTheme.floatingActionButtonTheme.backgroundColor,
          title: Text(themeProvider.getAdditionTodoListDialog(),
            style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText1?.color),
          ),
          content: TextField(
            onChanged: (String value) {
              _userToDo = value;
            },
            style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText1?.color), // Цвет текста в поле ввода
            cursorColor: themeProvider.currentTheme.textTheme.bodyText1?.color, // Цвет подсветки
            decoration: InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.currentTheme.textTheme.bodyText1?.color ?? Colors.white), // Цвет подсветки при фокусе
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: themeProvider.currentTheme.textTheme.bodyText1?.color ?? Colors.white), // Цвет подсветки в статичном положении
              ),
            ),
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
              child: Text(themeProvider.getAdditionTodoListButton(),
                style: TextStyle(color: themeProvider.currentTheme.textTheme.bodyText2?.color),
              ),
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                  themeProvider.currentTheme.primaryColor,
                ),
              ),
            ),
          ],
        );
      },
    );
  },
  child: Icon(Icons.add, size: 30.0, color: themeProvider.currentTheme.floatingActionButtonTheme.foregroundColor),
),

      );
    },
  );
}
}
