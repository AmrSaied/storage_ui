abstract class Storage {
  Future<List<String>> getKeys();
  Future<T?> read<T>(String key);
  Future<void> write(String key, dynamic value);
  Future<void> delete(String key);
}
