import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';

part 'todo_editor_view_model.g.dart';

@riverpod
class TodoEditorViewModel extends _$TodoEditorViewModel {
  @override
  TodoEditorState build(Todo? todo) {
    return TodoEditorState(
      id: todo?.id,
      title: todo?.title ?? "",
      memo: todo?.memo ?? "",
      isUpdate: todo != null,
    );
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void clearTitle() {
    setTitle('');
  }

  void setMemo(String memo) {
    state = state.copyWith(memo: memo);
  }

  bool isWritable() => (state.title != '') && (state.memo != '');

  Future<void> saveTodo({
    Function(int id)? onSuccess,
    Function()? onLoading,
    Function()? onFailure,
  }) async {
    if(onLoading != null) onLoading();

    final repository = await ref.read(todoRepositoryProvider.future);
    int id = 0;
    final todo = Todo(
      id: state.id,
      title: state.title,
      memo: state.memo,
    );

    if(state.isUpdate) {
      id = await repository.update(todo);
    } else {
      id = await repository.insert(todo);
    }

    if(onSuccess != null) onSuccess(id);
  }
}
