import 'package:flutter/services.dart';
import 'my_snack_bar.dart';

void copyToClipBoard({
  required context,
  required String text,
})
{
  Clipboard.setData(ClipboardData(text: text)).then((_) {
    callMySnackBar(context: context, text: 'copied to clipboard');
  });
}