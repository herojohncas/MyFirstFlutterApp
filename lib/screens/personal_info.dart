import 'package:flutter/material.dart';
import 'package:first_application/service/personal_info_service.dart';

class PersonalInfoPage extends StatefulWidget {
  @override
  _PersonalInfoPageState createState() => _PersonalInfoPageState();
}

class _PersonalInfoPageState extends State<PersonalInfoPage> {
  final TextEditingController fnameController = TextEditingController();
  final TextEditingController mnameController = TextEditingController();
  final TextEditingController lnameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final PersonalInfoService personalInfoService = PersonalInfoService();


  void handleSubmit() async {
    final fname = fnameController.text.trim();
    final mname = mnameController.text.trim();
    final lname = lnameController.text.trim();
    final email = emailController.text.trim();
    final age = ageController.text.trim();
    final address = addressController.text.trim();

    print("First Name: $fname");
    print("Middle Name: $mname");
    print("Last Name: $lname");
    print("Email: $email");
    print("Age: $age");
    print("Address: $address");

    await personalInfoService.insertUserData(fname, mname, lname, email, age, address);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Data inserted successfully')),
    );
    fnameController.clear();
    mnameController.clear();
    lnameController.clear();
    ageController.clear();
    emailController.clear();
    addressController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("User Info Form")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField("First Name", fnameController),
            _buildTextField("Middle Name", mnameController),
            _buildTextField("Last Name", lnameController),
            _buildTextField("Email", emailController, keyboardType: TextInputType.emailAddress),
            _buildTextField("Age", ageController, keyboardType: TextInputType.number),
            _buildTextField("Address", addressController),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
              ),
              onPressed: handleSubmit,
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller, {TextInputType? keyboardType}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}