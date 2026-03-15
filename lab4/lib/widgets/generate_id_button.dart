import 'package:flutter/material.dart';

class GenerateIdButton extends StatelessWidget {
  const GenerateIdButton({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFF0E7490),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        icon: const Icon(Icons.badge_outlined),
        label: const Text(
          'Generate ID',
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
      ),
    );
  }
}
