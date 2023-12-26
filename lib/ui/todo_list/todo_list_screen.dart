import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_body.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

/// Todoリスト画面
class TodoListScreen extends ConsumerWidget {
  // Todo登録画面への遷移処理
  final Function()? _navigateToEntry;
  // Todo更新画面への遷移処理
  final Function(Todo)? _navigateToUpdate;

  /// Todoリスト画面を生成します。
  ///
  /// FABが押下された場合の遷移先を[navigateToEntry]に登録します。
  const TodoListScreen({
    super.key,
    Function()? navigateToEntry,
    Function(Todo)? navigateToUpdate,
  }): _navigateToEntry = navigateToEntry,
        _navigateToUpdate = navigateToUpdate;

  /// Todoリスト画面を作成します。
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(todoListViewModelProvider);
    final viewModel = ref.watch(todoListViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('簡単なTODOアプリ'),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TodoListBody(
          state: state,
          viewModel: viewModel,
          onTodoTap: _navigateToUpdate,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToEntry,
        child: const Icon(Icons.add),
      ),
    );
  }
}
