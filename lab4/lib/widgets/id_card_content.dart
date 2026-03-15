import 'package:flutter/material.dart';
import 'package:lab4/models/user_form_data.dart';

class IdCardContent extends StatelessWidget {
  const IdCardContent({
    super.key,
    required this.idNumber,
    required this.userData,
  });

  final String idNumber;
  final UserFormData userData;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF0EA5E9), Color(0xFF155E75), Color(0xFF164E63)],
        ),
        boxShadow: const [
          BoxShadow(
            color: Color(0x33000000),
            blurRadius: 16,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'STATE OF HAWAII',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
              fontSize: 15,
            ),
          ),
          const SizedBox(height: 4),
          const Text(
            'DRIVER LICENSE - SAMPLE ID',
            style: TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 14),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 98,
                height: 118,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.white54),
                ),
                child: const Icon(
                  Icons.account_circle,
                  size: 72,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _idLine('ID Number', idNumber),
                    _idLine('Name', userData.name),
                    _idLine('Height', '${userData.heightCm} cm'),
                    _idLine('Weight', '${userData.weightKg} kg'),
                    _idLine('Hair', userData.hairColor),
                    _idLine('Eyes', userData.eyeColor),
                    _idLine('Sex', userData.sex),
                    _idLine('City', userData.city),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _idLine('Address', userData.address),
          const SizedBox(height: 18),
          const Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  'Aloha Signature',
                  style: TextStyle(
                    color: Colors.white,
                    fontStyle: FontStyle.italic,
                    fontWeight: FontWeight.w600,
                    fontSize: 16,
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Authorized Signatory',
                  style: TextStyle(color: Colors.white70, fontSize: 11),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _idLine(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 12.5,
              ),
            ),
            TextSpan(
              text: value,
              style: const TextStyle(color: Colors.white, fontSize: 12.5),
            ),
          ],
        ),
      ),
    );
  }
}
