import 'dart:math';

import 'package:flutter/material.dart';
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

  String _generateLicenseNumber() {
    final int a = 100000 + _random.nextInt(900000);
    final int b = 10 + _random.nextInt(90);
    return 'HI-$a-$b';
  }

  // Builds one model object so the dialog receives all form data in one place.
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
      appBar: AppBar(
        title: const Text('User Input and Forms'),
        centerTitle: true,
        elevation: 0,
        backgroundColor: const Color(0xFF0E7490),
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFE2F5F9),
                borderRadius: BorderRadius.circular(18),
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x1A000000),
                    blurRadius: 16,
                    offset: Offset(0, 8),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Laboratory Exercise: User Input and Forms',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF0F172A),
                    ),
                  ),
                  const SizedBox(height: 14),
                  CustomTextField(
                    controller: _nameController,
                    labelText: 'Name *',
                    icon: Icons.person_outline,
                    validator: (String? value) =>
                        _requiredFieldValidator(value, fieldName: 'Name'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: CustomTextField(
                          controller: _heightController,
                          labelText: 'Height (cm) *',
                          icon: Icons.height,
                          keyboardType: TextInputType.number,
                          validator: (String? value) =>
                              _requiredFieldValidator(value, fieldName: 'Height'),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: CustomTextField(
                          controller: _weightController,
                          labelText: 'Weight (kg) *',
                          icon: Icons.monitor_weight_outlined,
                          keyboardType: TextInputType.number,
                          validator: (String? value) =>
                              _requiredFieldValidator(value, fieldName: 'Weight'),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
                  CustomDropdownField(
                    labelText: 'Sex *',
                    icon: Icons.wc,
                    items: _sexOptions,
                    value: _selectedSex,
                    onChanged: (String? value) {
                      setState(() => _selectedSex = value);
                    },
                    validator: (String? value) => value == null ? 'Sex is required' : null,
                  ),
                  const SizedBox(height: 12),
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
                  const SizedBox(height: 12),
                  CustomTextField(
                    controller: _addressController,
                    labelText: 'Address *',
                    icon: Icons.home_outlined,
                    maxLines: 3,
                    alignLabelWithHint: true,
                    validator: (String? value) =>
                        _requiredFieldValidator(value, fieldName: 'Address'),
                  ),
                  const SizedBox(height: 18),
                  GenerateIdButton(onPressed: _showIdDialog),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
