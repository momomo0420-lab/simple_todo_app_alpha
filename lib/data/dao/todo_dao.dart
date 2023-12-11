abstract class TodoDao {
  Future<int> insert(Map<String, dynamic> todo);
  Future<int> update(int id, Map<String, dynamic> todo);
  Future<void> deleteBy(int id);
  Future<List<Map<String, dynamic>>> findAll();
}
