import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:untitled2/constants/widgets/vg_add_template.dart';
import 'package:untitled2/constants/widgets/vg_scaffold.dart';
import 'package:untitled2/models/game_type.dart';

class AddPage extends StatefulWidget {
  final String title;
  const AddPage({required this.title, super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return VGScaffold(
        title: widget.title,
        body: SingleChildScrollView(
            child: Padding(
          padding: const EdgeInsets.all(20),
          child: AddGame(),
        )));
  }
}
