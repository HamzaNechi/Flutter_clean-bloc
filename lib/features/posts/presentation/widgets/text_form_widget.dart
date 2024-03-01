import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isMultilines;
  final String validateText;
  final String hintTextValue;
  const TextFormFieldWidget({super.key, required this.controller, required this.isMultilines, required this.validateText, required this.hintTextValue});

  @override
  Widget build(BuildContext context) {
    return Padding(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: TextFormField(
              controller: controller,
              validator: (value) => value!.isEmpty ? validateText : null,
              decoration: InputDecoration(
                hintText: hintTextValue
              ),
              maxLines: isMultilines ? 6 : 1,
              minLines: isMultilines ? 6 : 1,
            
            ),
          );
  }
}