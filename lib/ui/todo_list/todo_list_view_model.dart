import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/ui/todo_list/todo_list_state.dart';

part 'todo_list_view_model.g.dart';

/// Todoリスト画面のビューモデル
@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  /// Todo編集画面のビューモデルで使用する状態を作成する。
  @override
  FutureOr<TodoListState> build() async {
    // Todoリストの読み込み
    final repository = await ref.read(todoRepositoryProvider.future);
    final todoList = await repository.findAll();

    // ローカルキャッシュを登録
    return TodoListState(todoList: todoList);
  }

  /// Todoリストを削除する。
  ///
  /// 主キー（[id]）に対応するTodoリストを削除する。
  Future<void> deleteTodo(int id) async {
    // Todoの削除
    final repository = await ref.read(todoRepositoryProvider.future);
    await repository.deleteBy(id);
    // ローカルキャッシュの更新
    ref.invalidateSelf();
  }
}
