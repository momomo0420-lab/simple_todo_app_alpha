import 'package:simple_todo_app_alpha/data/model/todo.dart';

/// Todoリポジトリ
///
/// このリポジトリを使用し、ビューモデルはTodoを扱う
abstract class TodoRepository {
  /// Todoを保存する。
  ///
  /// [todo]を保存します。
  /// 保存が完了すると、その主キーを返却する。
  Future<int> insert(Todo todo);

  /// 保存されているTodoを更新する。
  ///
  /// 保存されているTodoを[todo]の内容で更新する。
  /// 保存が完了すると、その主キーを返却する。
  Future<int> update(Todo todo);

  /// 保存されているTodoを削除する。
  ///
  /// 主キー[id]に保存されているTodoを削除する。
  Future<void> deleteBy(int id);

  /// 保存されているTodoを全件取得する。
  ///
  /// Todoをリスト型にて全件取得する。
  Future<List<Todo>> findAll();
}
