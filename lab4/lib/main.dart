import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const UserInputFormsApp());
}

class UserInputFormsApp extends StatelessWidget {
  const UserInputFormsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'User Input and Forms',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0E7490),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF1F5F9),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFFD1D5DB)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: const BorderSide(color: Color(0xFF0E7490), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        ),
      ),
      home: const UserFormPage(),
    );
  }
}

class UserFormPage extends StatefulWidget {
  const UserFormPage({super.key});

  @override
  State<UserFormPage> createState() => _UserFormPageState();
}

class _UserFormPageState extends State<UserFormPage> {
  final _formKey = GlobalKey<FormState>();

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

  String? _requiredFieldValidator(String? value, {String fieldName = 'Field'}) {
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

  void _showIdDialog() {
    final bool isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid ||
        _selectedHairColor == null ||
        _selectedEyeColor == null ||
        _selectedSex == null) {
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

    showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640, maxHeight: 580),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: _buildLicenseCard(idNumber),
                    ),
                  ),
                  const SizedBox(height: 14),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF0F766E),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
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
      },
    );
  }

  Widget _buildLicenseCard(String idNumber) {
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
                    _idLine('Name', _nameController.text.trim()),
                    _idLine('Height', '${_heightController.text.trim()} cm'),
                    _idLine('Weight', '${_weightController.text.trim()} kg'),
                    _idLine('Hair', _selectedHairColor ?? ''),
                    _idLine('Eyes', _selectedEyeColor ?? ''),
                    _idLine('Sex', _selectedSex ?? ''),
                    _idLine('City', _selectedCity),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          _idLine('Address', _addressController.text.trim()),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.bottomRight,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: const [
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
                  TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name *',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) =>
                        _requiredFieldValidator(value, fieldName: 'Name'),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _heightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Height (cm) *',
                            prefixIcon: Icon(Icons.height),
                          ),
                          validator: (value) => _requiredFieldValidator(
                            value,
                            fieldName: 'Height',
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextFormField(
                          controller: _weightController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Weight (kg) *',
                            prefixIcon: Icon(Icons.monitor_weight_outlined),
                          ),
                          validator: (value) => _requiredFieldValidator(
                            value,
                            fieldName: 'Weight',
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedHairColor,
                    decoration: const InputDecoration(
                      labelText: 'Hair Color *',
                      prefixIcon: Icon(Icons.palette_outlined),
                    ),
                    items: _hairColors
                        .map(
                          (String color) => DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() => _selectedHairColor = value);
                    },
                    validator: (value) => value == null ? 'Hair color is required' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedEyeColor,
                    decoration: const InputDecoration(
                      labelText: 'Eye Color *',
                      prefixIcon: Icon(Icons.visibility_outlined),
                    ),
                    items: _eyeColors
                        .map(
                          (String color) => DropdownMenuItem<String>(
                            value: color,
                            child: Text(color),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() => _selectedEyeColor = value);
                    },
                    validator: (value) => value == null ? 'Eye color is required' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedSex,
                    decoration: const InputDecoration(
                      labelText: 'Sex *',
                      prefixIcon: Icon(Icons.wc),
                    ),
                    items: _sexOptions
                        .map(
                          (String sex) => DropdownMenuItem<String>(
                            value: sex,
                            child: Text(sex),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      setState(() => _selectedSex = value);
                    },
                    validator: (value) => value == null ? 'Sex is required' : null,
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<String>(
                    value: _selectedCity,
                    decoration: const InputDecoration(
                      labelText: 'City *',
                      prefixIcon: Icon(Icons.location_city_outlined),
                    ),
                    items: _cities
                        .map(
                          (String city) => DropdownMenuItem<String>(
                            value: city,
                            child: Text(city),
                          ),
                        )
                        .toList(),
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() => _selectedCity = value);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _addressController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      labelText: 'Address *',
                      prefixIcon: Icon(Icons.home_outlined),
                      alignLabelWithHint: true,
                    ),
                    validator: (value) =>
                        _requiredFieldValidator(value, fieldName: 'Address'),
                  ),
                  const SizedBox(height: 18),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: _showIdDialog,
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
