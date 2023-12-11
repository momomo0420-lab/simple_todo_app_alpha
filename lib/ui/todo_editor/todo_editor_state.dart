import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_editor_state.freezed.dart';

@freezed
class TodoEditorState with _$TodoEditorState {
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