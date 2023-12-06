import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_body.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';

class TodoEditorScreen extends ConsumerWidget {
  final Function()? _navigateToNextScreen;

  const TodoEditorScreen({
    super.key,
    Function()? navigateToNextScreen,
  }): _navigateToNextScreen = navigateToNextScreen;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final viewModel = ref.watch(todoEditorViewModelProvider.notifier);
    final state = ref.watch(todoEditorViewModelProvider);

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
          navigateNextScreen: _navigateToNextScreen,
        ),
      ),
    );
  }
}
