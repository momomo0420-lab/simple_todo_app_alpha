import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_screen.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_screen.dart';

/// 全画面の定義クラス
enum AppScreens {
  /// Todoリスト画面
  todoList('/todo_list'),
  /// Todo登録画面
  todoEntry('/todo_entry'),
  /// Todo更新画面
  todoUpdate('/todo_update'),
  ;

  /// パス
  final String path;

  const AppScreens(this.path);
}

/// 画面のナビゲーションクラス
class AppNavigator extends StatelessWidget {
  /// 画面のナビゲーションを生成する。
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
        AppScreens.todoList.path : (BuildContext context) => _buildTodoList(context),
        AppScreens.todoEntry.path : (BuildContext context) => _buildTodoEntry(context),
        AppScreens.todoUpdate.path : (BuildContext context) => _buildTodoUpdate(context),
      },
      initialRoute: AppScreens.todoList.path,
    );
  }

  /// Todoリスト画面を作成する。
  ///
  /// 遷移時のパラメータとして[context]を使用する。
  Widget _buildTodoList(
    BuildContext context,
  ) {
    return TodoListScreen(
      navigateToEntry: () => Navigator.of(context).pushNamed(AppScreens.todoEntry.path),
      navigateToUpdate: (todo) => Navigator.of(context).pushNamed(
        AppScreens.todoUpdate.path,
        arguments: todo,
      ),
    );
  }

  /// Todo登録画面を作成する。
  ///
  /// 遷移時のパラメータとして[context]を使用する。
  Widget _buildTodoEntry(
    BuildContext context,
  ) {
    return TodoEditorScreen(
      navigateBack: () => Navigator.of(context).pushNamedAndRemoveUntil(
        AppScreens.todoList.path,
        (route) => false,
      ),
    );
  }

  /// Todo更新画面を作成する。
  ///
  /// 遷移時のパラメータとして[context]を使用する。
  /// ※現状登録画面を流用しています。
  Widget _buildTodoUpdate(
    BuildContext context,
  ) {
    // 前の画面で選択されたTodoを取得する。
    final todo = ModalRoute.of(context)?.settings.arguments as Todo?;

    return TodoEditorScreen(
      todo: todo,
      navigateBack: () => Navigator.of(context).pushNamedAndRemoveUntil(
        AppScreens.todoList.path,
        (route) => false
      ),
    );
  }
}
