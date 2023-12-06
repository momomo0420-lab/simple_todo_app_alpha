import 'package:simple_todo_app_alpha/data/model/todo.dart';

abstract class TodoRepository {
  Future<int> insert(Todo todo);
  Future<void> update(int id, Todo todo);
  Future<void> deleteBy(int id);
  Future<List<Todo>> findAll();
}
