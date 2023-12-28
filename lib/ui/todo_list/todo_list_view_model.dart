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
  /// 取得が行われる前に[onLoading]が実行され、成功した場合に[onSuccess]を実行する。
  /// 登録が失敗した場合、[onFailure]を実行する。※現状、失敗が実行されることはありません。
  Future<void> loadTodoList({
    Function()? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    // 開始処理
    if(onLoading != null) onLoading();

    // Todoリストの取得
    final repository = await ref.read(todoRepositoryProvider.future);
    final todoList = await repository.findAll();
    state = state.copyWith(todoList: todoList);

    // 終了処理
    if(onSuccess != null) onSuccess();
  }

  /// Todoリストを削除する。
  ///
  /// 主キー（[id]）に対応するTodoリストを削除する。
  /// 削除が行われる前に[onLoading]が実行され、成功した場合に[onSuccess]を実行する。
  /// 削除が失敗した場合、[onFailure]を実行する。※現状、失敗が実行されることはありません。
  Future<void> deleteTodo(
    int id, {
    Function()? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    // 開始処理
    if(onLoading != null) onLoading();

    // Todoの削除
    final repository = await ref.read(todoRepositoryProvider.future);
    await repository.deleteBy(id);

    // 終了処理
    if(onSuccess != null) onSuccess();
  }
}
