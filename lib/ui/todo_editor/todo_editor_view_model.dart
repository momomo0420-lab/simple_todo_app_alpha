import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';

part 'todo_editor_view_model.g.dart';

/// Todo編集画面のビューモデル
@riverpod
class TodoEditorViewModel extends _$TodoEditorViewModel {

  /// Todo編集画面のビューモデルで使用する状態を作成する。
  ///
  /// 更新の場合は[TodoEditorState]に[todo]を設定する。
  @override
  TodoEditorState build(Todo? todo) {
    return TodoEditorState(
      id: todo?.id,
      title: todo?.title ?? "",
      memo: todo?.memo ?? "",
      isUpdate: todo?.id != null,
    );
  }

  /// 状態に[title]を設定する。
  ///
  /// 状態が変更されるためUIの再描画が行われる。
  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  /// 状態に設定されているタイトルを初期化する。
  ///
  /// 状態が変更されるためUIの再描画が行われる。
  void clearTitle() {
    setTitle('');
  }

  /// 状態に[memo]を設定する。
  ///
  /// 状態が変更されるためUIの再描画が行われる。
  void setMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  /// Todoがデータベースに書き込み可能か判定する。
  bool isWritable() => (state.title != '') && (state.memo != '');

  /// Todoをデータベースに初期登録する。
  ///
  /// 登録が行われる前に[onLoading]が実行され、成功した場合に[onSuccess]を実行する。
  /// この時、データベースに登録した際の主キー（[id]）を返却する。
  /// 登録が失敗した場合、[onFailure]を実行する。※現状、失敗が実行されることはありません。
  Future<void> entryTodo({
    Function(int id)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    // 開始処理
    if(onLoading != null) onLoading();

    // データベースへの登録
    final repository = await ref.read(todoRepositoryProvider.future);
    final todo = Todo(
      title: state.title,
      memo: state.memo,
    );
    final id = await repository.insert(todo);

    // 終了処理
    if(onSuccess != null) onSuccess(id);
  }

  /// データベース上のTodoを更新する。
  ///
  /// 更新が行われる前に[onLoading]が実行され、成功した場合に[onSuccess]を実行する。
  /// この時、データベースに登録した際の主キー（[id]）を返却する。
  /// 更新が失敗した場合、[onFailure]を実行する。※現状、失敗実行されることはありません。
  Future<void> updateTodo({
    Function(int id)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    // 開始処理
    if(onLoading != null) onLoading();

    // 登録内容の更新
    final repository = await ref.read(todoRepositoryProvider.future);
    final todo = Todo(
      id: state.id!,
      title: state.title,
      memo: state.memo,
    );
    final id = await repository.update(todo);

    // 終了処理
    if(onSuccess != null) onSuccess(id);
  }
}
