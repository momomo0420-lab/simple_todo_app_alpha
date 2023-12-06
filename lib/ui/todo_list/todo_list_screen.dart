import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_body.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_view_model.dart';

class TodoListScreen extends ConsumerWidget {
  final Function()? _onFabPressed;
  final Function(int)? _navigateToDetail;

  const TodoListScreen({
    super.key,
    Function()? onFabPressed,
    Function(int)? navigateToDetail,
  }): _onFabPressed = onFabPressed,
        _navigateToDetail = navigateToDetail;

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
          navigateToDetail: _navigateToDetail,
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _onFabPressed,
        child: const Icon(Icons.add),
      ),
    );
  }
}
