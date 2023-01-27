import 'package:flutter/material.dart';
import 'package:storage_ui/core/page_style.dart';

import 'flutter_clipboard_custom.dart';

class CacheStorageText extends StatefulWidget {
  final String initialValue;
  final void Function(String newValue) onUpdate;
  final PageStyle pageStyle;
  const CacheStorageText({
    Key? key,
    required this.initialValue,
    required this.onUpdate,
    required this.pageStyle,
  }) : super(key: key);

  @override
  State<CacheStorageText> createState() => _CacheStorageTextState();
}

class _CacheStorageTextState extends State<CacheStorageText> {
  late TextEditingController _textEditingController;
  late FocusNode _focusNode;
  @override
  void initState() {
    _textEditingController = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const buttonSize = Size(100, 50);
    return Row(
      children: [
        const SizedBox(width: 16),
        Expanded(
          child: EditableText(
            controller: _textEditingController,
            backgroundCursorColor: widget.pageStyle.backgroundCursorColor,
            focusNode: _focusNode,
            cursorColor: widget.pageStyle.cursorColor,
            style: TextStyle(color: widget.pageStyle.textColor),
            maxLines: null,
          ),
        ),
        const SizedBox(width: 16),
        Row(
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                fixedSize: buttonSize,
              ),
              onPressed: () async {
                await FlutterClipboardCustom.copy(_textEditingController.text);
                // PopUpHelper.showToast("Clipboard", "copied_to_clipboard");
              },
              child: const Text('copy'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                fixedSize: buttonSize,
              ),
              onPressed: () =>
                  _textEditingController.text = widget.initialValue,
              child: const Text('Reset'),
            ),
            const SizedBox(width: 16),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                fixedSize: buttonSize,
              ),
              onPressed: () => widget.onUpdate(_textEditingController.text),
              child: const Text('Confirm'),
            ),
            const SizedBox(width: 32),
          ],
        ),
      ],
    );
  }
}
