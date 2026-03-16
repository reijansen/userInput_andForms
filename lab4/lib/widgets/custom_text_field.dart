import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField({
    super.key,
    required this.controller,
    required this.labelText,
    required this.icon,
    this.keyboardType,
    this.maxLines = 1,
    this.validator,
    this.alignLabelWithHint = false,
    this.inputFormatters,
  });

  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final TextInputType? keyboardType;
  final int maxLines;
  final String? Function(String?)? validator;
  final bool alignLabelWithHint;
  final List<TextInputFormatter>? inputFormatters;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      style: const TextStyle(
        fontSize: 14.5,
        color: Color(0xFF0F172A),
        fontWeight: FontWeight.w500,
      ),
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 2),
          child: Icon(icon, size: 20),
        ),
        alignLabelWithHint: alignLabelWithHint,
        prefixIconConstraints: const BoxConstraints(minWidth: 44, minHeight: 44),
      ),
    );
  }
}
