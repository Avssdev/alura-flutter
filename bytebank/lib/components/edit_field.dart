import 'package:flutter/material.dart';

class EditField extends StatelessWidget {
  const EditField({
    this.label,
    this.hint,
    this.controller,
    this.iconData,
    Key? key,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? iconData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: controller,
        style: const TextStyle(
          fontSize: 24.0,
        ),
        decoration: InputDecoration(
          icon: iconData != null ? Icon(iconData) : null,
          labelText: label,
          hintText: hint,
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
