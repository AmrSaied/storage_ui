import 'package:flutter/material.dart';
import 'package:storage_ui/storage_ui.dart';

import 'flutter_clipboard_custom.dart';

class CacheStorageDate extends StatefulWidget {
  final String initialValue;
  final void Function(String newValue) onUpdate;
  final PageStyle pageStyle;
  const CacheStorageDate({
    Key? key,
    required this.initialValue,
    required this.onUpdate,
    required this.pageStyle,
  }) : super(key: key);

  @override
  State<CacheStorageDate> createState() => _CacheStorageDateState();
}

class _CacheStorageDateState extends State<CacheStorageDate> {
  late DateTime initialDate;
  late DateTime firstDate;
  late DateTime lastDate;
  late String newPickedDate;

  @override
  void initState() {
    newPickedDate = widget.initialValue;
    super.initState();
  }

  void initDatePicker() {
    final now = DateTime.now();
    initialDate = DateTime.parse(widget.initialValue);
    firstDate = now.subtract(const Duration(days: 30 * 4));
    lastDate = now.add(const Duration(days: 30 * 4));
  }

  @override
  Widget build(BuildContext context) {
    const buttonSize = Size(100, 50);

    return Row(
      children: [
        const SizedBox(width: 16),
        GestureDetector(
          onTap: () async {
            initDatePicker();
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: initialDate,
              firstDate: firstDate,
              lastDate: lastDate,
            );
            if (pickedDate != null) {
              newPickedDate = pickedDate.toIso8601String();
              setState(() {});
            }
          },
          child: Text(newPickedDate),
        ),
        const Expanded(child: SizedBox()),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            fixedSize: buttonSize,
          ),
          onPressed: () async {
            await FlutterClipboardCustom.copy(newPickedDate);
            // PopUpHelper.showToast("Clipboard", "copied_to_clipboard");
          },
          child: const Text('Copy'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            fixedSize: buttonSize,
          ),
          onPressed: () => setState(() => newPickedDate = widget.initialValue),
          child: const Text('Reset'),
        ),
        const SizedBox(width: 16),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: widget.pageStyle.confirmColor,
            fixedSize: buttonSize,
          ),
          onPressed: () => widget.onUpdate(newPickedDate),
          child: const Text('Confirm'),
        ),
        const SizedBox(width: 32),
      ],
    );
  }
}
