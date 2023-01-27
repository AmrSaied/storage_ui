import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_storage/get_storage.dart';
import 'package:storage_ui/core/get_storage/get_storage.dart';
import 'package:storage_ui/core/secure_storage/secure_storage.dart';
import 'package:storage_ui/storage_ui.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await _fillStorage();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final secureStorage = SecureStorage();
    final getStorage = GetStorageImpl();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CacheStorageLogPage(
        cacheStorage: getStorage,
        pageStyle: PageStyle(
          appBarColor: Colors.blue,
          backgroundCursorColor: Colors.black26,
          confirmColor: Colors.green,
          cursorColor: Colors.black,
          textColor: Colors.black,
        ),
        onError: (message) {
          print(message);
        },
      ),
    );
  }
}

Future<void> _fillStorage() async {
  final storage = GetStorage();
  await storage.write('name', "Jonny");
  await storage.write('id', 235454);
  await storage.write('date', DateTime.now().toString());
  await storage.write('info', {
    "address": "Egypt",
    "marital_status": "Single",
    "telephone": 0123456789,
  });
  const secureStorage = FlutterSecureStorage();
  await secureStorage.write(key: 'name', value: "Jonny");
  await secureStorage.write(key: 'id', value: "235454");
  await secureStorage.write(key: 'date', value: DateTime.now().toString());
}
