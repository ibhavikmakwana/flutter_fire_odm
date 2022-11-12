import 'package:flutter/material.dart';
import 'package:flutter_fire_odm/model/user.dart';

enum ScreenState { add, update }

class AddUpdateScreen extends StatefulWidget {
  final ScreenState state;
  final String? id;
  const AddUpdateScreen({
    super.key,
    required this.state,
    this.id,
  });

  @override
  State<AddUpdateScreen> createState() => _AddUpdateScreenState();
}

class _AddUpdateScreenState extends State<AddUpdateScreen> {
  late final TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: controller,
              decoration: const InputDecoration(
                hintText: 'Add text',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          MaterialButton(
            color: Theme.of(context).primaryColor,
            onPressed: saveOrUpdate,
            child: Text(getTitle),
          ),
        ],
      ),
    );
  }

  void saveOrUpdate() {
    if (controller.text.trim().isNotEmpty) {
      switch (widget.state) {
        case ScreenState.add:
          usersRef.add(User(name: controller.text));
          break;
        case ScreenState.update:
          usersRef.doc(widget.id).update(name: controller.text);
          break;
      }
      Navigator.of(context).pop();
    }
  }

  String get getTitle {
    switch (widget.state) {
      case ScreenState.add:
        return 'Add';
      case ScreenState.update:
        return 'Update';
    }
  }

  String get getButtonTitle {
    switch (widget.state) {
      case ScreenState.add:
        return 'Save';
      case ScreenState.update:
        return 'Update';
    }
  }
}
