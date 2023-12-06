import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_screen.dart';

enum SimpleTodoAppScreens {
  todoList('/todo_list'),
  todoEditor('/todo_editor'),
  ;

  final String screen;

  const SimpleTodoAppScreens(this.screen);
}

class AppNavigator extends StatelessWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '簡単なTODOアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),

      routes: <String, WidgetBuilder> {
        SimpleTodoAppScreens.todoList.screen: (BuildContext context) {
          return TodoListScreen(
            onFabPressed: () => Navigator.of(context).pushNamed(
              SimpleTodoAppScreens.todoEditor.screen
            ),
          );
        },

        SimpleTodoAppScreens.todoEditor.screen: (BuildContext context) {
          return TodoEditorScreen(
            navigateToNextScreen: () => Navigator.of(context).pushNamedAndRemoveUntil(
              SimpleTodoAppScreens.todoList.screen,
              (route) => false,
            ),
          );
        },
      },

      initialRoute: SimpleTodoAppScreens.todoList.screen,
    );
  }
}
