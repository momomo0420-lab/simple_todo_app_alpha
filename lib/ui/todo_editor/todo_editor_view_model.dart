import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/app_container.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/ui/todo_editor/todo_editor_state.dart';

part 'todo_editor_view_model.g.dart';

@riverpod
class TodoEditorViewModel extends _$TodoEditorViewModel {
  @override
  TodoEditorState build() {
    return const TodoEditorState();
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

  bool isWritable() {
    bool result = true;

    if((state.title == '') ||
        (state.memo == '')) {
      result = false;
    }

    return result;
  }

  Future<void> saveTodo({
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
}
