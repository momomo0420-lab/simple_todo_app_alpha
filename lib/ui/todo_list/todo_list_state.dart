import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';

part 'todo_list_state.freezed.dart';

@freezed
class TodoListState with _$TodoListState {
  const factory TodoListState({
    @Default(null)
    List<Todo>? todoList,
  }) = _TodoListState;
}