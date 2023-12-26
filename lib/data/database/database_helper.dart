import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

/// Todoテーブルに使用するカラムの定義クラス
enum TodoTableColumns {
  /// 主キー
  id('id'),
  /// タイトル
  title('title'),
  /// メモ
  memo('memo'),
  ;

  /// カラム
  final String column;

  const TodoTableColumns(this.column);
}

/// データベースのヘルパークラス
///
/// このクラスはシングルトンで扱います。
class DatabaseHelper {
  // シングルトン
  DatabaseHelper._();
  static final DatabaseHelper _instance = DatabaseHelper._();
  factory DatabaseHelper() => _instance;

  /// データベース名
  static const databaseName = 'todo_database.db';
  /// データベースバージョン
  static const databaseVer = 1;
  /// テーブル名
  static const tableName = 'todo_table';

  /// データベースの実態
  ///
  /// 外部から呼び出す際は[db]を使用する。
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
        ${TodoTableColumns.id.column} INTEGER PRIMARY KEY AUTOINCREMENT,
        ${TodoTableColumns.title.column} TEXT,
        ${TodoTableColumns.memo.column} TEXT
      )
    ''');
  }
}