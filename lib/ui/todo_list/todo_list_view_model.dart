import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';

part 'todo_list_view_model.g.dart';

/// Todoリスト画面のビューモデル
@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  /// Todo編集画面のビューモデルで使用する状態を作成する。
  @override
  TodoListState build() {
    return const TodoListState();
  }

  /// Todoリストを取得する。
  ///
  /// 現状、登録されているTodoリストを全件取得する。
  Future<void> loadTodoList() async {
    final repository = await ref.read(todoRepositoryProvider.future);
    final todoList = await repository.findAll();
    state = state.copyWith(todoList: todoList);
  }

  /// Todoリストを削除する。
  ///
  /// 主キー（[id]）に対応するTodoリストを削除する。
  /// その後、Todoリストを更新する。
  Future<void> deleteTodo(int id) async {
    final repository = await ref.read(todoRepositoryProvider.future);
    await repository.deleteBy(id);
    final todoList = await repository.findAll();
    state = state.copyWith(todoList: todoList);
  }
}
