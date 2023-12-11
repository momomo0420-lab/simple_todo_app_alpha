import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';

part 'todo_list_view_model.g.dart';

/// Todoリスト画面のビューモデル
@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  /// このビューモデルは[TodoListState]を状態として使用します。
  @override
  TodoListState build() {
    return const TodoListState();
  }

  /// Todoリストを取得します。
  ///
  /// 現状、登録されているTodoリストを全件取得します。
  Future<void> loadTodoList() async {
    final repository = await ref.read(todoRepositoryProvider.future);
    final todoList = await repository.findAll();
    state = state.copyWith(todoList: todoList);
  }

  /// Todoリストを削除します。
  ///
  /// [id]に対応するTodoリストを削除します。
  /// その後、Todoリストを更新します。
  Future<void> deleteTodo(int id) async {
    final repository = await ref.read(todoRepositoryProvider.future);
    await repository.deleteBy(id);
    final todoList = await repository.findAll();
    state = state.copyWith(todoList: todoList);
  }
}
