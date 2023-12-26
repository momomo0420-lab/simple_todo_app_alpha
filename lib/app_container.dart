import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:simple_todo_app_alpha/data/dao/todo_dao.dart';
import 'package:simple_todo_app_alpha/data/dao/todo_dao_impl.dart';
import 'package:simple_todo_app_alpha/data/database/database_helper.dart';
import 'package:simple_todo_app_alpha/data/repository/todo_repository.dart';
import 'package:simple_todo_app_alpha/data/repository/todo_repository_impl.dart';

part 'app_container.g.dart';

@riverpod
Future<TodoDao> todoDao(TodoDaoRef ref) async {
  final db = await DatabaseHelper().db;
  return TodoDaoImpl(db: db);
}

@riverpod
Future<TodoRepository> todoRepository(TodoRepositoryRef ref) async {
  final dao = await ref.watch(todoDaoProvider.future);
  return TodoRepositoryImpl(dao: dao);
}