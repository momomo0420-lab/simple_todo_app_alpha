import 'package:simple_todo_app_alpha/data/dao/todo_dao.dart';
import 'package:simple_todo_app_alpha/data/model/todo.dart';
import 'package:simple_todo_app_alpha/data/repository/todo_repository.dart';

class TodoRepositoryImpl implements TodoRepository {
  final TodoDao _dao;

  const TodoRepositoryImpl({
    required TodoDao dao,
  }): _dao = dao;

  @override
  Future<int> insert(Todo todo) async {

    return await _dao.insert(todo.toJson());
  }

  @override
  Future<void> update(int id, Todo todo) async {
    await _dao.update(id, todo.toJson());
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