import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

enum AppScreens {
  todoList('/todo_list'),
  todoEntry('/todo_entry'),
  todoUpdate('/todo_update'),
  ;

  final String path;

  const AppScreens(this.path);
}

class AppNavigator extends ConsumerWidget {
  const AppNavigator({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: '簡単なTODOアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: <String, WidgetBuilder> {
        AppScreens.todoList.path : (BuildContext context) => buildTodoList(context, ref),
        AppScreens.todoEntry.path : (BuildContext context) => buildTodoEntry(context, ref),
        AppScreens.todoUpdate.path : (BuildContext context) => buildTodoUpdate(context, ref),
      },
      initialRoute: AppScreens.todoList.path,
    );
  }

  Widget buildTodoList(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = ref.watch(todoListViewModelProvider);
    final viewModel = ref.watch(todoListViewModelProvider.notifier);

    return TodoListScreen(
      state: state,
      viewModel: viewModel,
      navigateToEntry: () => Navigator.of(context).pushNamed(AppScreens.todoEntry.path),
      navigateToUpdate: (todo) => Navigator.of(context).pushNamed(
        AppScreens.todoUpdate.path,
        arguments: todo,
      ),
    );
  }

  Widget buildTodoEntry(
    BuildContext context,
    WidgetRef ref,
  ) {
    final state = ref.watch(todoEditorViewModelProvider(null));
    final viewModel = ref.watch(todoEditorViewModelProvider(null).notifier);

    return TodoEditorScreen(
      state: state,
      viewModel: viewModel,
      navigateBack: () => Navigator.of(context).pushNamedAndRemoveUntil(
        AppScreens.todoList.path,
        (route) => false,
      ),
    );
  }

  Widget buildTodoUpdate(
    BuildContext context,
    WidgetRef ref,
  ) {
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;
    final state = ref.watch(todoEditorViewModelProvider(todo));
    final viewModel = ref.watch(todoEditorViewModelProvider(todo).notifier);

    return TodoEditorScreen(
      state: state,
      viewModel: viewModel,
      navigateBack: () => Navigator.of(context).pushNamedAndRemoveUntil(
        AppScreens.todoList.path,
        (route) => false
      ),
    );
  }
}
