import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';

part 'todo_list_view_model.g.dart';

@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  @override
  TodoListState build() {
    return const TodoListState();
  }

  Future<void> loadTodoList() async {
    final repository = await ref.read(todoRepositoryProvider.future);
    final todoList = await repository.findAll();
    state = state.copyWith(todoList: todoList);
  }
}
