import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class VGDialog extends StatelessWidget {
  final Widget content;
  const VGDialog({
    required this.content,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: SizedBox(
          height: MediaQuery.of(context).size.height / 2.5,
          child: Padding(padding: const EdgeInsets.all(20.0), child: content)),
    );
  }
}
