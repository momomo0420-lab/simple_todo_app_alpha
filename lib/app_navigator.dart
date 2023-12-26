import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

/// 全画面の定義クラス
enum AppScreens {
  todoList('/todo_list'),
  todoEntry('/todo_entry'),
  todoUpdate('/todo_update'),
  ;

  final String path;

  const AppScreens(this.path);
}

/// 画面のナビゲーションクラス
class AppNavigator extends ConsumerWidget {
  /// 画面のナビゲーションを生成する。
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
        AppScreens.todoList.path : (BuildContext context) => _buildTodoList(context, ref),
        AppScreens.todoEntry.path : (BuildContext context) => _buildTodoEntry(context, ref),
        AppScreens.todoUpdate.path : (BuildContext context) => _buildTodoUpdate(context, ref),
      },
      initialRoute: AppScreens.todoList.path,
    );
  }

  /// Todoリスト画面を作成する。
  ///
  ///[context]と[ref]を使用し必要なパラメータを取得する。
  Widget _buildTodoList(
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

  /// Todo登録画面を作成する。
  ///
  ///[context]と[ref]を使用し必要なパラメータを取得する。
  Widget _buildTodoEntry(
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

  /// Todo更新画面を作成する。
  ///
  ///[context]と[ref]を使用し必要なパラメータを取得する。
  /// ※現状登録画面を流用しています。
  Widget _buildTodoUpdate(
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
