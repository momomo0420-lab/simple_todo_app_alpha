import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_body.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';

/// Todo編集画面
class TodoEditorScreen extends ConsumerWidget {
  // Todoアイテム
  final Todo? _todo;
  // 登録完了後の処理
  final Function()? _navigateBack;

  /// Todo編集画面を生成する。
  ///
  /// [todo]がnullの場合は登録処理を、データが存在する場合は更新処理を行う。
  /// Todoの登録後、[navigateBack]を実行する。
  const TodoEditorScreen({
    super.key,
    Todo? todo,
    Function()? navigateBack,
  }): _todo = todo,
        _navigateBack = navigateBack;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 状態
    final state = ref.watch(todoEditorViewModelProvider(_todo));
    // ビューモデル
    final viewModel = ref.watch(todoEditorViewModelProvider(_todo).notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('TODO作成画面'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TodoEditorBody(
          viewModel: viewModel,
          state: state,
          onSaved: _navigateBack,
        ),
      ),
    );
  }
}
