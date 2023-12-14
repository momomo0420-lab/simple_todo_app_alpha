import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';

part 'todo_editor_view_model.g.dart';

/// Todoエディタ画面のビューモデル
@riverpod
class TodoEditorViewModel extends _$TodoEditorViewModel {

  /// Todoエディタ画面のビューモデルで使用する状態を作成します。
  ///
  /// 更新の場合は状態[TodoEditorState]に[todo]を設定します。
  @override
  TodoEditorState build(Todo? todo) {
    return TodoEditorState(
      id: todo?.id,
      title: todo?.title ?? "",
      memo: todo?.memo ?? "",
      isUpdate: todo != null,
    );
  }

  /// 状態に[title]を設定します。
  ///
  /// 状態が変更されるためUIの再描画が行われます。
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  /// 状態に設定されているタイトルを初期化します。
  ///
  /// 状態が変更されるためUIの再描画が行われます。
  void clearTitle() {
    setTitle('');
  }

  /// 状態に[memo]を設定します。
  ///
  /// 状態が変更されるためUIの再描画が行われます。
  void setMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  /// Todoがデータベースに書き込み可能か判定します。
  bool isWritable() => (state.title != '') && (state.memo != '');

  /// Todoをデータベースに初期登録します。
  ///
  /// 登録が行われる前に[onLoading]が実行されます。
  /// 登録が成功した場合、[onSuccess]を実行します。
  /// この時、データベースに登録した際の主キー[id]を返却します。
  /// 登録が失敗した場合、[onFailure]を実行します。※現状これが実行されることはありません。
  Future<void> entryTodo({
    Function(int id)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = await ref.read(todoRepositoryProvider.future);
    final todo = Todo(
      title: state.title,
      memo: state.memo,
    );
    final id = await repository.insert(todo);

    if(onSuccess != null) onSuccess(id);
  }

  /// データベース上のTodoを更新します。
  ///
  /// 更新が行われる前に[onLoading]が実行されます。
  /// 更新が成功した場合、[onSuccess]を実行します。
  /// この時、データベースに登録した際の主キー[id]を返却します。
  /// 更新が失敗した場合、[onFailure]を実行します。※現状これが実行されることはありません。
  Future<void> updateTodo({
    Function(int id)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = await ref.read(todoRepositoryProvider.future);
    final todo = Todo(
      id: state.id!,
      title: state.title,
      memo: state.memo,
    );
    final id = await repository.update(todo);

    if(onSuccess != null) onSuccess(id);
  }
}
