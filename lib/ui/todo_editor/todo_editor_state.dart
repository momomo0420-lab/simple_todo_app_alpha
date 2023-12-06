import 'package:freezed_annotation/freezed_annotation.dart';

part 'todo_editor_state.freezed.dart';

@freezed
class TodoEditorState with _$TodoEditorState {
  const factory TodoEditorState ({
    @Default('')
    String title,
    @Default('')
    String memo,
  }) = _TodoEditorState;
}