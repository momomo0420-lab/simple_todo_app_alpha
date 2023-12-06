abstract class TodoDao {
  Future<int> insert(Map<String, dynamic> todo);
  Future<void> update(int id, Map<String, dynamic> todo);
  Future<void> deleteBy(int id);
  Future<List<Map<String, dynamic>>> findAll();
  Future<Map<String, dynamic>> findBy(int id);
}
