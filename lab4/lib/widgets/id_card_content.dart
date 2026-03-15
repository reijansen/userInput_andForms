import 'dart:math';
import 'dart:ui';

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
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        // Keep real ID-like ratio, but enforce a minimum height on small widths
        // so the content does not overflow vertically.
        final double cardWidth = constraints.maxWidth;
        final double cardHeight = max(cardWidth / 1.58, 360.0);

        return SizedBox(
          height: cardHeight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(22),
            child: Stack(
              children: [
            Positioned.fill(
              child: Container(
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Color(0xFF075985), Color(0xFF0E7490), Color(0xFF155E75)],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -12,
              right: -40,
              child: Transform.rotate(
                angle: -pi / 7,
                child: Container(
                  width: 190,
                  height: 28,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    gradient: const LinearGradient(
                      colors: [
                        Color(0x66FFFFFF),
                        Color(0x66BAE6FD),
                        Color(0x33FFFFFF),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              right: 18,
              bottom: 18,
              child: Transform.rotate(
                angle: -pi / 9,
                child: Text(
                  'ALOHA',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.08),
                    fontSize: 38,
                    fontWeight: FontWeight.w800,
                    letterSpacing: 3,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 7, sigmaY: 7),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.10),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.33),
                      width: 1.2,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 14, 16, 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.20),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Colors.white.withOpacity(0.42),
                          ),
                        ),
                        child: const Icon(
                          Icons.shield_outlined,
                          size: 18,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(width: 10),
                      const Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'STATE OF HAWAII',
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w700,
                                fontSize: 13.5,
                                letterSpacing: 1.05,
                              ),
                            ),
                            SizedBox(height: 1),
                            Text(
                              'HAWAII DRIVER LICENSE  -  SAMPLE ID',
                              style: TextStyle(
                                color: Color(0xD6E2F1F8),
                                fontSize: 10.8,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.35,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: 1,
                    color: Colors.white.withOpacity(0.30),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 88,
                          height: 108,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.white.withOpacity(0.30),
                                Colors.white.withOpacity(0.12),
                              ],
                            ),
                            border: Border.all(
                              color: Colors.white.withOpacity(0.70),
                              width: 1.2,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x280F172A),
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.account_circle,
                            size: 60,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              _buildPair('ID NUMBER', idNumber, emphasize: true),
                              _buildPair('NAME', userData.name),
                              Row(
                                children: [
                                  Expanded(child: _buildPair('HEIGHT', '${userData.heightCm} cm')),
                                  const SizedBox(width: 8),
                                  Expanded(child: _buildPair('WEIGHT', '${userData.weightKg} kg')),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: _buildPair('HAIR', userData.hairColor)),
                                  const SizedBox(width: 8),
                                  Expanded(child: _buildPair('EYES', userData.eyeColor)),
                                ],
                              ),
                              Row(
                                children: [
                                  Expanded(child: _buildPair('SEX', userData.sex)),
                                  const SizedBox(width: 8),
                                  Expanded(child: _buildPair('CITY', userData.city)),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                  _buildPair('ADDRESS', userData.address),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Text(
                        'DL CLASS C',
                        style: TextStyle(
                          color: Colors.white.withOpacity(0.86),
                          fontSize: 10.5,
                          letterSpacing: 0.4,
                        ),
                      ),
                      const Spacer(),
                      const Text(
                        'Aloha Signature',
                        style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600,
                          fontSize: 13.5,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
              ],
            ),
          ),
        ),
      },
    );
  }

  Widget _buildPair(String label, String value, {bool emphasize = false}) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              color: Colors.white.withOpacity(0.78),
              fontSize: 9.8,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: emphasize ? 14 : 12.3,
              fontWeight: emphasize ? FontWeight.w700 : FontWeight.w600,
              letterSpacing: emphasize ? 0.2 : 0,
              height: 1.08,
            ),
          ),
        ],
      ),
    );
  }
}
