import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_screen.dart';

enum AppScreens {
  todoList('/todo_list'),
  todoEditor('/todo_editor'),
  ;

  final String path;

  const AppScreens(this.path);
}

class AppRouter extends StatelessWidget {
  const AppRouter({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: '簡単なTODOアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: buildGoRouter(),
    );
  }

  GoRouter buildGoRouter() {
    return GoRouter(
      initialLocation: AppScreens.todoList.path,
      routes: [
        GoRoute(
          path: AppScreens.todoList.path,
          builder: (context, state) => TodoListScreen(
            navigateToEntry: () => context.push(AppScreens.todoEditor.path),
            navigateToUpdate: (todo) => context.push(
              AppScreens.todoEditor.path,
              extra: todo,
            ),
          ),
        ),

        GoRoute(
          path: AppScreens.todoEditor.path,
          builder: (context, state) => TodoEditorScreen(
            navigateBack: () {
              while(context.canPop()) {
                context.pop();
              }
              context.pushReplacement(AppScreens.todoList.path);
            },
            todo: state.extra as Todo?,
          ),
        ),
      ],
    );
  }
}
