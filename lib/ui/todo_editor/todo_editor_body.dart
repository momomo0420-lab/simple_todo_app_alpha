import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';
import 'package:simple_todo_app_alpha/ui/widget/multiple_lines_text_field.dart';
import 'package:simple_todo_app_alpha/ui/widget/one_line_text_field.dart';

class TodoEditorBody extends StatefulWidget {
  final TodoEditorViewModel _viewModel;
  final TodoEditorState _state;

  final Function()? _navigateToNextScreen;

  const TodoEditorBody({
    super.key,
    required TodoEditorViewModel viewModel,
    required TodoEditorState state,
    Function()? navigateNextScreen,
  }): _viewModel = viewModel,
        _state = state,
        _navigateToNextScreen = navigateNextScreen;

  @override
  State<TodoEditorBody> createState() => _TodoEditorBodyState();
}

class _TodoEditorBodyState extends State<TodoEditorBody> {
  late final TextEditingController _titleController;
  late final TextEditingController _memoController;

  @override
  void initState() {
    super.initState();

    _titleController = TextEditingController();
    _memoController = TextEditingController();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _memoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        OneLineTextField(
          controller: _titleController,
          label: 'タイトル',
          hint: 'タイトルを入力してください',
          onChanged: (title) => widget._viewModel.setTitle(title),
          onClear: () => widget._viewModel.clearTitle(),
        ),
        const SizedBox(height: 10,),

        MultipleLinesTextField(
          controller: _memoController,
          label: 'メモ',
          hint: 'メモを入力してください',
          onChanged: (memo) => widget._viewModel.setMemo(memo),
        ),
        const SizedBox(height: 10,),

        Center(
          child: ElevatedButton(
            onPressed: !widget._viewModel.isWritable() ? null :
              () => widget._viewModel.saveTodo(
                onSuccess: (int id) {
                  if(widget._navigateToNextScreen != null) widget._navigateToNextScreen!();
                },
              ),
            child: const Text('保存'),
          ),
        )
      ],
    );
  }
}
