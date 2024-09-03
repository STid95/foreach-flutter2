import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/utils/say_hello.dart';

class VGScaffold extends StatelessWidget {
  const VGScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  final String title;
  final Widget body;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.account_circle),
        actions: [
          InkWell(
            child: Icon(Icons.login),
            onTap: sayHello,
            splashColor: Colors.red,
          ),
        ],
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: Text(title),
      ),
      body: body,
    );
  }
}
