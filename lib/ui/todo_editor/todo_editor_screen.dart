import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_body.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';

/// Todoエディタ画面
class TodoEditorScreen extends StatelessWidget {
  // 状態
  final TodoEditorState _state;
  // ビューモデル
  final TodoEditorViewModel _viewModel;
  // 登録完了後の処理
  final Function()? _navigateBack;

  /// Todoエディタ画面を生成します。
  ///
  /// Todoの登録後、[navigateBack]を実行します。
  const TodoEditorScreen({
    super.key,
    required TodoEditorState state,
    required TodoEditorViewModel viewModel,
    Function()? navigateBack,
    Todo? todo,
  }): _state = state,
        _viewModel = viewModel,
        _navigateBack = navigateBack;

  /// メイン
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TODO作成画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TodoEditorBody(
          viewModel: _viewModel,
          state: _state,
          onSaved: _navigateBack,
        ),
      ),
    );
  }
}
