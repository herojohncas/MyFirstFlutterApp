import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:first_application/service/personal_info_service.dart';
import 'package:first_application/screens/dashboard.dart';

class PersonalInfoPage extends StatefulWidget {
  final Map<String, dynamic>? initialData;

  PersonalInfoPage({this.initialData});
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

  @override
  void initState() {
    super.initState();
    if (widget.initialData != null) {
      fnameController.text = widget.initialData!['fname'] ?? '';
      mnameController.text = widget.initialData!['mname'] ?? '';
      lnameController.text = widget.initialData!['lname'] ?? '';
      ageController.text = widget.initialData!['age']?.toString() ?? '';
      addressController.text = widget.initialData!['address'] ?? '';
      emailController.text = widget.initialData!['email'] ?? '';
    }
  }


  void handleSubmit() async {
    final fname = fnameController.text.trim();
    final mname = mnameController.text.trim();
    final lname = lnameController.text.trim();
    final email = emailController.text.trim();
    final age = ageController.text.trim();
    final address = addressController.text.trim();

    if (fname.isEmpty || lname.isEmpty || age.isEmpty || email.isEmpty || address.isEmpty) {
      String missingFields = "";
      if (fname.isEmpty) missingFields += "First Name, ";
      if (lname.isEmpty) missingFields += "Last Name, ";
      if (age.isEmpty) missingFields += "Age, ";
      if (email.isEmpty) missingFields += "Email, ";
      if (address.isEmpty) missingFields += "Address, ";

      // Remove trailing comma and space if the missing fields contains 1
      if (missingFields.isNotEmpty) {
        missingFields = missingFields.substring(0, missingFields.length - 2);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill in the following fields: $missingFields')),
      );
      return;
    }

    // Validate first name, middle name, and last name for letters and spaces only
    final nameRegex = RegExp(r'^[a-zA-Z0-9\s]+$');
    if (!nameRegex.hasMatch(fname)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('First Name can only contain alphanumeric characters and spaces.')),
      );
      return;
    }
    if (!nameRegex.hasMatch(lname)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Last Name can only contain alphanumeric characters and spaces.')),
      );
      return;
    }
    // Validate email format
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(email)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid email address.')),
      );
      return;
    }

    // Validate age (must be a number between 1 and 150)
    final ageRegex = RegExp(r'^[1-9][0-9]?$|^1[0-4][0-9]$|^150$');
    if (!ageRegex.hasMatch(age)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a valid age (1-150).')),
      );
      return;
    }

    // Validate address (allow alphanumeric characters, spaces, and common punctuation)
    final addressRegex = RegExp(r'^[a-zA-Z0-9\s\.,#-]+$');
    if (!addressRegex.hasMatch(address)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Address can only contain alphanumeric characters, spaces, and .,#-')),
      );
      return;
    }






    print("First Name: $fname");
    print("Middle Name: $mname");
    print("Last Name: $lname");
    print("Email: $email");
    print("Age: $age");
    print("Address: $address");

    await personalInfoService.insertUserData(
      fname,
      mname,
      lname,
      email,
      age,
      address,
      // imageUrl: imageUrl,
    );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Data inserted successfully')));
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
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => DashboardPage()),
            );
          },
        ),
        title: Text("Personal Info Form", style: TextStyle(color: Colors.white)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildTextField("First Name", fnameController, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))]),
            _buildTextField("Middle Name", mnameController, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))]),
            _buildTextField("Last Name", lnameController, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z\s]'))]),
            _buildTextField(
              "Email",
              emailController,
              keyboardType: TextInputType.emailAddress,
              inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9@\._-]'))],
            ),
            _buildTextField(
              "Age",
              ageController,
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly, LengthLimitingTextInputFormatter(3)],
            ),
            _buildTextField("Address", addressController, inputFormatters: [FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9\s\.,#-]'))]),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
              onPressed: handleSubmit,
              child: Text("Save", style: TextStyle(color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label,
    TextEditingController controller, {
    TextInputType? keyboardType,
    List<TextInputFormatter>? inputFormatters,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType ?? TextInputType.text,
        inputFormatters: inputFormatters,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
