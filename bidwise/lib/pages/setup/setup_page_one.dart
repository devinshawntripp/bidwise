import 'package:bidwise/services/Users/app_user_functions.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SetupPage extends StatefulWidget {
  final User? firebaseUser;

  const SetupPage({Key? key, this.firebaseUser}) : super(key: key);

  @override
  _SetupPageState createState() => _SetupPageState();
}

class _SetupPageState extends State<SetupPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  int _currentStep = 0;
  String? _firstName;
  String? _lastName;
  bool _isLookingForContractor = false;
  bool _isContractor = false;
  bool _hasLicense = false;
  List<String> _specialties = [];
  List<String> _allSpecialties = [
    'General Contractor',
    'Bathroom Remodeler',
    'Handyman',
    'Landscaper',
    'Paver',
    'Insulation'
  ];

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController(
        text: widget.firebaseUser?.displayName?.split(' ').first);
    _lastNameController = TextEditingController(
        text: widget.firebaseUser?.displayName?.split(' ').last);
    _firstName = widget.firebaseUser?.displayName?.split(' ').first;
    _lastName = widget.firebaseUser?.displayName?.split(' ').last;
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  Widget _buildStepOne() {
    return Column(
      children: [
        TextField(
          decoration: const InputDecoration(labelText: 'First Name'),
          controller: _firstNameController,
          onChanged: (value) => setState(() => _firstName = value),
        ),
        TextField(
          decoration: const InputDecoration(labelText: 'Last Name'),
          controller: _lastNameController,
          onChanged: (value) => setState(() => _lastName = value),
        ),
        CheckboxListTile(
          title: const Text('Looking for a Contractor'),
          value: _isLookingForContractor,
          onChanged: (bool? value) {
            setState(() {
              _isLookingForContractor = value ?? false;
              _isContractor = false;
            });
          },
        ),
        CheckboxListTile(
          title: const Text('Contractor'),
          value: _isContractor,
          onChanged: (bool? value) {
            setState(() {
              _isContractor = value ?? false;
              _isLookingForContractor = false;
            });
          },
        ),
      ],
    );
  }

  Widget _buildStepTwoContractor() {
    return Column(
      children: [
        CheckboxListTile(
          title: const Text('Do you have any licenses?'),
          value: _hasLicense,
          onChanged: (bool? value) {
            setState(() {
              _hasLicense = value ?? false;
            });
          },
        ),
        if (_hasLicense)
          ElevatedButton(
            onPressed: () {
              // Trigger file upload
            },
            child: const Text('Upload License/Certification'),
          ),
        DropdownButtonFormField<String>(
          items: _allSpecialties.map((String specialty) {
            return DropdownMenuItem<String>(
              value: specialty,
              child: Text(specialty),
            );
          }).toList(),
          onChanged: (value) {
            if (!_specialties.contains(value)) {
              setState(() {
                _specialties.add(value ?? '');
              });
            }
          },
          hint: Text('Select your specialties'),
        ),
        Wrap(
          children: _specialties.map((e) => Chip(label: Text(e))).toList(),
        ),
      ],
    );
  }

  Widget _buildStepThreeSummary() {
    return Column(
      children: [
        ListTile(
          title: Text('First Name: $_firstName'),
          subtitle: Text('Last Name: $_lastName'),
        ),
        ListTile(
          title: Text(
              'Role: ${_isContractor ? "Contractor" : "Looking for Contractor"}'),
          subtitle: Text(
              _isContractor ? 'Specialties: ${_specialties.join(', ')}' : ''),
        ),
        ElevatedButton(
          onPressed: () async {
            // Save data to Firestore and navigate to home
            List<String> projects = [];
            double rating = 0.0; // Default rating if not specified
            List<String> reviews = [];
            Map<String, int> availability = {};
            List<String> certifications = [];
            await createUser(
                widget.firebaseUser!,
                _isContractor ? ['Contractor'] : [''],
                _firstName ?? '',
                _lastName ?? '',
                projects,
                rating,
                reviews,
                _specialties,
                availability,
                certifications);

            Navigator.pushNamed(context, '/home');
          },
          child: const Text('Submit'),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup Your Profile')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _currentStep == 0
              ? _buildStepOne()
              : _currentStep == 1 && _isContractor
                  ? _buildStepTwoContractor()
                  : _buildStepThreeSummary(),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          // Back button
          if (_currentStep >
              0) // Only show the back button if not on the first step
            FloatingActionButton(
              onPressed: () {
                if (_currentStep > 0) {
                  setState(() => _currentStep--);
                }
              },
              child: Icon(Icons.arrow_back),
              backgroundColor: Colors.blue,
            ),
          // Forward button
          FloatingActionButton(
            onPressed: _isContractor && _currentStep < 2 ||
                    !_isContractor && _currentStep < 1
                ? () {
                    setState(() => _currentStep++);
                  }
                : null,
            child: Icon(Icons.arrow_forward),
            backgroundColor: (_isContractor && _currentStep < 2 ||
                    !_isContractor && _currentStep < 1)
                ? Colors.blue
                : Colors.grey,
          ),
        ],
      ),
    );
  }
}
