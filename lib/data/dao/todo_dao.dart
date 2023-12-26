/// Todoを扱うデータベースのDAO
///
/// リポジトリはこのクラスを使用し、Todoの操作を行う。
abstract class TodoDao {
  /// Todoをデータベースへ登録する。
  ///
  /// マップ型の[todo]をデータベースに登録する。
  /// 登録が完了すると、その主キーを返却する。
  Future<int> insert(Map<String, dynamic> todo);

  /// データベースに登録されているTodoを更新する。
  ///
  /// 主キー[id]に登録されているTodoを更新する。
  /// 更新するデータはマップ型[todo]で渡す。
  /// 登録が完了すると、その主キーを返却する。
  Future<int> update(int id, Map<String, dynamic> todo);

  /// データベースに登録されているTodoを削除する。
  ///
  /// 主キー[id]に登録されているTodoを削除する。
  Future<void> deleteBy(int id);

  /// データベースに登録されているTodoを全件取得する。
  ///
  /// マップ型のTodoをリスト型にて全件取得する。
  Future<List<Map<String, dynamic>>> findAll();
}
