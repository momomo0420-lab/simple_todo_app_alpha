import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_body.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';

/// Todoエディタ画面
class TodoEditorScreen extends ConsumerWidget {
  final Function()? _navigateBack;
  final Todo? _todo;

  /// Todoエディタ画面を生成します。
  ///
  /// Todoの登録後、[navigateBack]を実行します。
  /// [todo]がnullの場合は初期登録を、nullじゃない場合は更新を行います。
  /// これは入力フォームに文字が初期設定されているか否かが変わります。
  const TodoEditorScreen({
    super.key,
    Function()? navigateBack,
    Todo? todo,
  }): _navigateBack = navigateBack,
        _todo = todo;

  /// メイン
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // ビューモデル
    final viewModel = ref.watch(todoEditorViewModelProvider(_todo).notifier);
    // 状態
    final state = ref.watch(todoEditorViewModelProvider(_todo));

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
