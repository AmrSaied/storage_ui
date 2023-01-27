import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:storage_ui/core/storage.dart';

class SecureStorage extends Storage {
  final FlutterSecureStorage secureStorage;

  SecureStorage() : secureStorage = const FlutterSecureStorage();
  SecureStorage.withOptions({
    WebOptions? webOptions,
    WindowsOptions? windowsOptions,
    AndroidOptions? androidOptions,
    IOSOptions? iosOptions,
    MacOsOptions? macOsOptions,
    LinuxOptions? linuxOptions,
  }) : secureStorage = FlutterSecureStorage(
          webOptions: webOptions ?? WebOptions.defaultOptions,
          aOptions: androidOptions ?? AndroidOptions.defaultOptions,
          iOptions: iosOptions ?? IOSOptions.defaultOptions,
          lOptions: linuxOptions ?? LinuxOptions.defaultOptions,
          mOptions: macOsOptions ?? MacOsOptions.defaultOptions,
          wOptions: windowsOptions ?? WindowsOptions.defaultOptions,
        );

  @override
  Future<List<String>> getKeys() async {
    final data = await secureStorage.readAll();
    return data.keys.toList();
  }

  @override
  Future<T?> read<T>(String key) async {
    return await secureStorage.read(key: key) as T;
  }

  @override
  Future<void> write(String key, value) async =>
      await secureStorage.write(key: key, value: value);

  @override
  Future<void> delete(String key) async => await secureStorage.delete(key: key);
}
