import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';

part 'todo_list_state.freezed.dart';

/// Todoリスト画面の状態
@freezed
class TodoListState with _$TodoListState {
  /// Todoリスト画面の状態を生成します
  const factory TodoListState({
    /// Todoリスト
    @Default(null)
    List<Todo>? todoList,
  }) = _TodoListState;
}