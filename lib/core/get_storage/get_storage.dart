import 'package:get_storage/get_storage.dart';
import 'package:storage_ui/core/storage.dart';

class GetStorageImpl extends Storage {
  final getStorage = GetStorage();
  @override
  Future<List<String>> getKeys() async => getStorage.getKeys().toList();

  @override
  Future<T?> read<T>(String key) async => getStorage.read<T>(key);

  @override
  Future<void> write(String key, value) async =>
      await getStorage.write(key, value);
  @override
  Future<void> delete(String key) async => await getStorage.remove(key);
}
