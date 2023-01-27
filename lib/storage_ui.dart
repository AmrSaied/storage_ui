library storage_ui;

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:storage_ui/core/page_style.dart';
import 'package:storage_ui/core/storage.dart';
import 'package:storage_ui/storage_ui.dart';
import 'package:storage_ui/widgets/date_widget.dart';
import 'package:storage_ui/widgets/text_widget.dart';

export 'package:storage_ui/core/page_style.dart';

class CacheStorageLogPage extends StatefulWidget {
  final PageStyle pageStyle;
  final Storage cacheStorage;
  final void Function(String) onError;

  const CacheStorageLogPage({
    Key? key,
    required this.cacheStorage,
    required this.onError,
    required this.pageStyle,
  }) : super(key: key);

  @override
  State<CacheStorageLogPage> createState() => _CacheStorageLogPageState();
}

class _CacheStorageLogPageState extends State<CacheStorageLogPage> {
  List<String> storageKeys = [];

  @override
  void initState() {
    super.initState();
    widget.cacheStorage.getKeys().then(
          (keys) => WidgetsBinding.instance.addPostFrameCallback(
            (_) => setState(
              () => storageKeys = List<String>.of(keys),
            ),
          ),
        );
  }

  Future<void> _deleteKey(String key) async {
    await widget.cacheStorage.delete(key);
    setState(() => storageKeys.remove(key));
  }

  Future<void> updateKey(String key, String newValue) async {
    try {
      await widget.cacheStorage.write(key, newValue.trim());
      setState(() {});
    } catch (e, _) {
      widget.onError(e.toString());
    }
  }

  bool isDateTime(dynamic value) {
    late DateTime? dateTimeParsedOrNull;
    if (value is String) {
      dateTimeParsedOrNull = DateTime.tryParse(value);

      return dateTimeParsedOrNull != null;
    } else {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor: primaryColor,
        title: const Text('Storage Ui'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: storageKeys.length,
        itemBuilder: (_, index) {
          final key = storageKeys[index];

          return FutureBuilder(
              future: widget.cacheStorage.read(key),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator.adaptive(),
                  );
                }
                final value = snapshot.data;
                late String prettyString;
                if (isDateTime(value)) {
                  prettyString = value as String;
                } else {
                  // prettyString = value as String;

                  prettyString =
                      const JsonEncoder.withIndent('  ').convert(value);
                }
                return ExpansionTile(
                  title: Text(key),
                  trailing: IconButton(
                    onPressed: () async {
                      await _deleteKey(key);
                    },
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                  ),
                  children: [
                    if (isDateTime(value))
                      CacheStorageDate(
                        initialValue: prettyString,
                        pageStyle: widget.pageStyle,
                        onUpdate: (newValue) async =>
                            await updateKey(key, newValue),
                      )
                    else
                      CacheStorageText(
                        initialValue: prettyString,
                        pageStyle: widget.pageStyle,
                        onUpdate: (newValue) async =>
                            await updateKey(key, newValue),
                      ),
                    const SizedBox(height: 16),
                  ],
                );
              });
        },
      ),
    );
  }
}
