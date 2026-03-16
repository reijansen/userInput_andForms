import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lab4/models/user_form_data.dart';
import 'package:lab4/widgets/custom_dropdown_field.dart';
import 'package:lab4/widgets/custom_text_field.dart';
import 'package:lab4/widgets/generate_id_button.dart';
import 'package:lab4/widgets/id_card_dialog.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({super.key});

  @override
  State<FormScreen> createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();

  final List<String> _hairColors = <String>[
    'Black',
    'Brown',
    'Blonde',
    'Red',
    'Gray',
    'Other',
  ];

  final List<String> _eyeColors = <String>[
    'Brown',
    'Black',
    'Blue',
    'Green',
    'Hazel',
    'Gray',
    'Other',
  ];

  final List<String> _sexOptions = <String>['Male', 'Female', 'Other'];
  final List<String> _cities = <String>['Honolulu', 'Hilo', 'Kailua', 'Pearl City'];

  String? _selectedHairColor;
  String? _selectedEyeColor;
  String? _selectedSex;
  String _selectedCity = 'Honolulu';

  final Random _random = Random();

  @override
  void dispose() {
    _nameController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  String? _requiredFieldValidator(String? value, {required String fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return '$fieldName is required';
    }
    return null;
  }

  String? _digitsOnlyValidator(String? value, {required String fieldName}) {
    final String? requiredError = _requiredFieldValidator(value, fieldName: fieldName);
    if (requiredError != null) {
      return requiredError;
    }
    if (!RegExp(r'^\d+$').hasMatch(value!.trim())) {
      return '$fieldName must contain digits only';
    }
    return null;
  }

  String _generateLicenseNumber() {
    final int a = 100000 + _random.nextInt(900000);
    final int b = 10 + _random.nextInt(90);
    return 'HI-$a-$b';
  }

  // Build one model object so the dialog receives all form data in one place.
  UserFormData _buildUserData() {
    return UserFormData(
      name: _nameController.text.trim(),
      heightCm: _heightController.text.trim(),
      weightKg: _weightController.text.trim(),
      hairColor: _selectedHairColor ?? '',
      eyeColor: _selectedEyeColor ?? '',
      sex: _selectedSex ?? '',
      city: _selectedCity,
      address: _addressController.text.trim(),
    );
  }

  void _showIdDialog() {
    final bool isValid = _formKey.currentState?.validate() ?? false;
    final bool dropdownsMissing =
        _selectedHairColor == null || _selectedEyeColor == null || _selectedSex == null;

    if (!isValid || dropdownsMissing) {
      setState(() {});
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please complete all required fields.'),
          backgroundColor: Color(0xFFB91C1C),
        ),
      );
      return;
    }

    final String idNumber = _generateLicenseNumber();
    final UserFormData userData = _buildUserData();

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return IdCardDialog(
          idNumber: idNumber,
          userData: userData,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Input and Forms')),
      body: SafeArea(
        child: Stack(
          children: [
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      const Color(0xFFE8F7FB),
                      const Color(0xFFF4F8FB),
                      const Color(0xFFF8FAFC),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: -90,
              right: -30,
              child: Container(
                width: 220,
                height: 220,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: RadialGradient(
                    colors: [Color(0x5038BDF8), Color(0x0038BDF8)],
                  ),
                ),
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 560),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(18),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(24),
                          gradient: const LinearGradient(
                            colors: [Color(0xFF0E7490), Color(0xFF0EA5A8)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: const [
                            BoxShadow(
                              color: Color(0x2A0E7490),
                              blurRadius: 24,
                              offset: Offset(0, 10),
                            ),
                          ],
                        ),
                        child: const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  radius: 20,
                                  backgroundColor: Color(0x33FFFFFF),
                                  child: Icon(
                                    Icons.badge_rounded,
                                    color: Colors.white,
                                    size: 22,
                                  ),
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'ID Generator',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Laboratory Exercise: User Input and Forms',
                              style: TextStyle(
                                color: Color(0xE6FFFFFF),
                                fontSize: 13.5,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: _formKey,
                        child: Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.92),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0x1F0E7490),
                              width: 1.1,
                            ),
                            boxShadow: const [
                              BoxShadow(
                                color: Color(0x160F172A),
                                blurRadius: 20,
                                offset: Offset(0, 10),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Personal Information',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFF0F172A),
                                ),
                              ),
                              const SizedBox(height: 4),
                              const Text(
                                'Fill out the fields below to generate a sample Hawaii-style ID.',
                                style: TextStyle(
                                  color: Color(0xFF64748B),
                                  fontSize: 13.2,
                                ),
                              ),
                              const SizedBox(height: 18),
                              CustomTextField(
                                controller: _nameController,
                                labelText: 'Name *',
                                icon: Icons.person_outline,
                                validator: (String? value) =>
                                    _requiredFieldValidator(value, fieldName: 'Name'),
                              ),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: CustomTextField(
                                      controller: _heightController,
                                      labelText: 'Height (cm) *',
                                      icon: Icons.height,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (String? value) =>
                                          _digitsOnlyValidator(value, fieldName: 'Height'),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: CustomTextField(
                                      controller: _weightController,
                                      labelText: 'Weight (kg) *',
                                      icon: Icons.monitor_weight_outlined,
                                      keyboardType: TextInputType.number,
                                      inputFormatters: <TextInputFormatter>[
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      validator: (String? value) =>
                                          _digitsOnlyValidator(value, fieldName: 'Weight'),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              CustomDropdownField(
                                labelText: 'Hair Color *',
                                icon: Icons.palette_outlined,
                                items: _hairColors,
                                value: _selectedHairColor,
                                onChanged: (String? value) {
                                  setState(() => _selectedHairColor = value);
                                },
                                validator: (String? value) =>
                                    value == null ? 'Hair color is required' : null,
                              ),
                              const SizedBox(height: 14),
                              CustomDropdownField(
                                labelText: 'Eye Color *',
                                icon: Icons.visibility_outlined,
                                items: _eyeColors,
                                value: _selectedEyeColor,
                                onChanged: (String? value) {
                                  setState(() => _selectedEyeColor = value);
                                },
                                validator: (String? value) =>
                                    value == null ? 'Eye color is required' : null,
                              ),
                              const SizedBox(height: 14),
                              CustomDropdownField(
                                labelText: 'Sex *',
                                icon: Icons.wc,
                                items: _sexOptions,
                                value: _selectedSex,
                                onChanged: (String? value) {
                                  setState(() => _selectedSex = value);
                                },
                                validator: (String? value) =>
                                    value == null ? 'Sex is required' : null,
                              ),
                              const SizedBox(height: 14),
                              CustomDropdownField(
                                labelText: 'City *',
                                icon: Icons.location_city_outlined,
                                items: _cities,
                                value: _selectedCity,
                                onChanged: (String? value) {
                                  if (value != null) {
                                    setState(() => _selectedCity = value);
                                  }
                                },
                              ),
                              const SizedBox(height: 14),
                              CustomTextField(
                                controller: _addressController,
                                labelText: 'Address *',
                                icon: Icons.home_outlined,
                                maxLines: 3,
                                alignLabelWithHint: true,
                                validator: (String? value) =>
                                    _requiredFieldValidator(value, fieldName: 'Address'),
                              ),
                              const SizedBox(height: 20),
                              GenerateIdButton(onPressed: _showIdDialog),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
