import 'package:simple_todo_app_alpha/data/dao/todo_dao.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/data/repository/todo_repository.dart';

/// Todoリポジトリ（実装）
class TodoRepositoryImpl implements TodoRepository {
  // Dao
  final TodoDao _dao;

  /// Todoリポジトリを生成する。
  ///
  /// データベース操作を行う[dao]を登録しておく。
  const TodoRepositoryImpl({
    required TodoDao dao,
  }): _dao = dao;

  @override
  Future<int> insert(Todo todo) async {

    return await _dao.insert(todo.toJson());
  }

  @override
  Future<int> update(Todo todo) async {
    return await _dao.update(todo.id!, todo.toJson());
  }

  @override
  Future<void> deleteBy(int id) async {
    await _dao.deleteBy(id);
  }

  @override
  Future<List<Todo>> findAll() async {
    final rows = await _dao.findAll();

    final todoList = <Todo>[];
    for(var row in rows) {
      todoList.add(Todo.fromJson(row));
    }

    return todoList;
  }
}