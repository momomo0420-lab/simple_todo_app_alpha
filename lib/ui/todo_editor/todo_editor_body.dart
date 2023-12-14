import 'package:flutter/material.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_view_model.dart';
import 'package:simple_todo_app_alpha/ui/widget/multiple_lines_text_field.dart';
import 'package:simple_todo_app_alpha/ui/widget/one_line_text_field.dart';

/// Todoエディタ画面のボディ
class TodoEditorBody extends StatefulWidget {
  // ビューモデル
  final TodoEditorViewModel _viewModel;
  // 状態
  final TodoEditorState _state;

  // Todo保存後の処理
  final Function()? _onSaved;

  /// Todoエディタ画面のボディを生成します。
  ///
  /// [viewModel]と[state]を使用し、表示させる内容やボタン押下時の処理などを決定します。
  /// [onSaved]はTodo保存後の動きを設定します。
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

  /// 初期化処理
  @override
  void initState() {
    super.initState();

    final state = widget._state;

    // コントローラーの初期化
    _titleController = TextEditingController(text: state.title);
    _memoController = TextEditingController(text: state.memo);
  }

  /// 終了処理
  @override
  void dispose() {
    // コントローラーの破棄
    _titleController.dispose();
    _memoController.dispose();

    super.dispose();
  }

  /// メイン
  @override
  Widget build(BuildContext context) {
    final viewModel = widget._viewModel;
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
          child: buildSaveButton(
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

  /// 保存用のボタンを作成します。
  ///
  /// [onEntry]はTodo初期登録時の動きを登録します。
  /// また[onUpdate]にはTodo更新時の動きを登録します。
  /// このボタンはTodoのタイトルとメモが両方入力されていない場合、押下が無効になります。
  ElevatedButton buildSaveButton({
    required Function()? onEntry,
    required Function()? onUpdate,
  }) {
    Text text;
    Function()? onPressed;

    if(widget._state.isUpdate) {
      text = const Text('更新');
      onPressed = onUpdate;
    } else {
      text = const Text('保存');
      onPressed = onEntry;
    }

    return ElevatedButton(
      onPressed: widget._viewModel.isWritable() ?
        () { if(onPressed != null) onPressed(); } : null,
      child: text,
    );
  }
}
