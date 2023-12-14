import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_editor_state.freezed.dart';

/// Todoエディタ画面の状態
@freezed
class TodoEditorState with _$TodoEditorState {
  /// Todoエディタ画面の状態を保存します。
  ///
  /// [id]にはデータベース登録用の主キーを設定します。nullの場合は自動で主キーが設定されます。
  /// [title][memo]にはTodoのタイトルとメモをそれぞれ設定します。
  /// [isUpdate]は処理が初期登録なのか？更新なのか？を設定します。
  const factory TodoEditorState ({
    @Default(null)
    int? id,
    @Default('')
    String title,
    @Default('')
    String memo,
    @Default(false)
    bool isUpdate,
  }) = _TodoEditorState;
}