import 'package:flutter/material.dart';

class TextEditingWidgetForUserForm extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final String validateText ;
  const TextEditingWidgetForUserForm({super.key, required this.controller, required this.hint, required this.validateText});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: controller,
              validator: (value) => value!.isEmpty ? validateText : null,
              decoration: InputDecoration(
                hintText: hint
              ),       
            ),
    );
  }
}