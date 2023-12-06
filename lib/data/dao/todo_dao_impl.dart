import 'package:simple_todo_app_alpha/data/dao/todo_dao.dart';
import 'package:simple_todo_app_alpha/data/database/database_helper.dart';
import 'package:sqflite/sqflite.dart';

class TodoDaoImpl implements TodoDao {
  final Database _db;

  const TodoDaoImpl({
    required Database db,
  }): _db = db;

  @override
  Future<int> insert(Map<String, dynamic> todo) async {
    return await _db.insert(
      DatabaseHelper.tableName,
      todo,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  @override
  Future<void> update(int id, Map<String, dynamic> todo) async {
    await _db.update(
      DatabaseHelper.tableName,
      todo,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<void> deleteBy(int id) async {
    await _db.delete(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  @override
  Future<List<Map<String, dynamic>>> findAll() async {
    return await _db.query(
      DatabaseHelper.tableName,
      orderBy: '${TodoDatabaseColumns.id.column} DESC',
    );
  }

  @override
  Future<Map<String, dynamic>> findBy(int id) async {
    final row = await _db.query(
      DatabaseHelper.tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return row.first;
  }
}
