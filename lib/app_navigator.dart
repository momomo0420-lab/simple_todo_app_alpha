import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
    return MaterialApp.router(
      title: '簡単なTODOアプリ',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routerConfig: _buildGoRouter(),
    );
  }

  /// 画面遷移のための構成を作成します。
  GoRouter _buildGoRouter() {
    return GoRouter(
      initialLocation: AppScreens.todoList.path,
      routes: [
        GoRoute(
          path: AppScreens.todoList.path,
          builder: _buildTodoList,
        ),
        GoRoute(
          path: AppScreens.todoEntry.path,
          builder: _buildTodoEntry,
        ),
        GoRoute(
          path: AppScreens.todoUpdate.path,
          builder: _buildTodoUpdate,
        ),
      ],
    );
  }

  /// Todoリスト画面を作成する。
  ///
  /// 遷移時のパラメータとして[context]、[state]を使用する。
  Widget _buildTodoList(
    BuildContext context,
    GoRouterState state,
  ) {
    return TodoListScreen(
      navigateToEntry: () => context.push(AppScreens.todoEntry.path),
      navigateToUpdate: (todo) => context.push(
        AppScreens.todoUpdate.path,
        extra: todo,
      ),
    );
  }

  /// Todo登録画面を作成する。
  ///
  /// 遷移時のパラメータとして[context]、[state]を使用する。
  Widget _buildTodoEntry(
    BuildContext context,
    GoRouterState state,
  ) {
    return TodoEditorScreen(
      navigateBack: () => context.go(AppScreens.todoList.path),
    );
  }

  /// Todo更新画面を作成する。
  ///
  /// 遷移時のパラメータとして[context]、[state]を使用する。
  /// ※現状登録画面を流用しています。
  Widget _buildTodoUpdate(
    BuildContext context,
    GoRouterState state,
  ) {
    // 前の画面で選択されたTodoを取得する。
    final todo = state.extra as Todo;

    return TodoEditorScreen(
      todo: todo,
      navigateBack: () => context.go(AppScreens.todoList.path),
    );
  }
}
