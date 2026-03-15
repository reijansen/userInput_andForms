import 'package:flutter/material.dart';
import 'package:lab4/models/user_form_data.dart';
import 'package:lab4/widgets/id_card_content.dart';

class IdCardDialog extends StatelessWidget {
  const IdCardDialog({
    super.key,
    required this.idNumber,
    required this.userData,
  });

  final String idNumber;
  final UserFormData userData;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 560, maxHeight: 620),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: const Color(0xAAE2F4FA),
            borderRadius: BorderRadius.circular(24),
            border: Border.all(color: const Color(0x66FFFFFF), width: 1),
            boxShadow: const [
              BoxShadow(
                color: Color(0x2A0F172A),
                blurRadius: 30,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Flexible(
                child: SingleChildScrollView(
                  child: IdCardContent(
                    idNumber: idNumber,
                    userData: userData,
                  ),
                ),
              ),
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF0F5F73),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                  icon: const Icon(Icons.close_rounded),
                  label: const Text('Close'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
