import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';
import 'package:simple_todo_app_alpha/ui/widget/multiple_lines_text_field.dart';
import 'package:simple_todo_app_alpha/ui/widget/one_line_text_field.dart';

/// Todo編集画面の本体
class TodoEditorBody extends StatefulWidget {
  // ビューモデル
  final TodoEditorViewModel _viewModel;
  // 状態
  final TodoEditorState _state;

  // Todo保存後の処理
  final Function()? _onSaved;

  /// Todo編集画面の本体を生成する。
  ///
  /// [viewModel]と[state]を使用し、表示させる内容やボタン押下時の処理などを決定する。
  /// [onSaved]はTodo保存後の動きを設定する。
  const TodoEditorBody({
    super.key,
    required TodoEditorViewModel viewModel,
    required TodoEditorState state,
    Function()? onSaved,
  }): _viewModel = viewModel,
        _state = state,
        _onSaved = onSaved;

  @override
  State<TodoEditorBody> createState() => _TodoEditorBodyState();
}

class _TodoEditorBodyState extends State<TodoEditorBody> {
  // タイトル用のコントローラー
  late final TextEditingController _titleController;
  // メモ用のコントローラー
  late final TextEditingController _memoController;

  @override
  void initState() {
    super.initState();

    // 状態
    final state = widget._state;

    // コントローラーの初期化
    _titleController = TextEditingController(text: state.title);
    _memoController = TextEditingController(text: state.memo);
  }

  @override
  void dispose() {
    // コントローラーの破棄
    _titleController.dispose();
    _memoController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 状態
    final state = widget._state;
    // ビューモデル
    final viewModel = widget._viewModel;

    // Todo保存後の処理
    final onSaved = widget._onSaved;

    return Column(
      children: [
        OneLineTextField(
          controller: _titleController,
          label: 'タイトル',
          hint: 'タイトルを入力してください',
          onChanged: (title) => viewModel.setTitle(title),
          onClear: () => viewModel.clearTitle(),
        ),
        const SizedBox(height: 10,),

        MultipleLinesTextField(
          controller: _memoController,
          label: 'メモ',
          hint: 'メモを入力してください',
          onChanged: (memo) => viewModel.setMemo(memo),
        ),
        const SizedBox(height: 10,),

        Center(
          child: _buildSaveButton(
            isUpdate: state.isUpdate,
            isWritable: viewModel.isWritable(),
            onEntry: () => viewModel.entryTodo(
              onSuccess: (_) { if(onSaved != null) onSaved(); },
            ),
            onUpdate: () => viewModel.updateTodo(
              onSuccess: (_) { if(onSaved != null) onSaved(); },
            ),
          ),
        ),
      ],
    );
  }

  /// 保存用のボタンを作成する。
  ///
  /// [onEntry]はTodo初期登録時の動きを登録する。
  /// また[onUpdate]にはTodo更新時の動きを登録する。
  /// 上記の判断は[isUpdate]にて判断される。（trueの場合は[onUpdate]の処理が行われる。）
  /// [isWritable]がfalse場合、押下が無効。
  ElevatedButton _buildSaveButton({
    required bool isUpdate,
    required bool isWritable,
    Function()? onEntry,
    Function()? onUpdate
  }) {
    // ボタンに表示されるテキスト
    late final Text text;
    // ボタン押下後の動作
    late final Function()? onPressed;

    // 登録処理か更新処理かを判断し、適応する値をセットする。
    if(isUpdate) {
      text = const Text('更新');
      onPressed = onUpdate;
    } else {
      text = const Text('保存');
      onPressed = onEntry;
    }

    return ElevatedButton(
      onPressed: isWritable ? onPressed : null,
      child: text,
    );
  }
}
