import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

enum TodoDatabaseColumns {
  id('id'),
  title('title'),
  memo('memo'),
  ;

  final String column;

  const TodoDatabaseColumns(this.column);
}

class DatabaseHelper {
  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;

  static const databaseName = 'todo_database.db';
  static const databaseVer = 1;
  static const tableName = 'todo_table';

  static Database? _db;
  Future<Database> get db async {
    if(_db == null) {
      final databasePath = await getDatabasesPath();
      final path = join(databasePath, databaseName);
      _db = await openDatabase(
        path,
        version: databaseVer,
        onCreate: _onCreate,
      );
    }

    return _db!;
  }

  /// テーブル作成
  Future<void> _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableName (
        ${TodoDatabaseColumns.id.column} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TodoDatabaseColumns.title.column} TEXT,
        ${TodoDatabaseColumns.memo.column} TEXT
      )
    ''');
  }
}