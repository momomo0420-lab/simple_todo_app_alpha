import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_editor_state.freezed.dart';

/// Todo編集画面の状態
@freezed
class TodoEditorState with _$TodoEditorState {
  /// Todo編集画面の状態を保持する。
  ///
  /// [id]にはデータベース登録用の主キーを設定する。nullの場合は自動で主キーが設定される。
  /// [title]、[memo]にはTodoのタイトルとメモをそれぞれ設定する。
  /// [isUpdate]は処理が初期登録なのか？更新なのか？を設定する。（trueの場合は更新）
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