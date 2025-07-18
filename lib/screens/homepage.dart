import 'package:flutter/material.dart';
import '/screens/dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}
class AppState {
  static String name = '';
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Profile Icon
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('images/profile.jpg'), // Ensure you have this image in your assets
                    ),
                    SizedBox(height: 20.0),
                    // App Description
                    Text(
                      'Hi, I`m Hero. This is a simple Flutter page I created to showcase my knowledge of Flutter.',
                      style: TextStyle(fontSize: 18, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.0),
                    // Name Input
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Enter your name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() => AppState.name = value);
                      },
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your name first.';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16),

                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => DashboardPage()));
                          }
                        },
                        child: Text(
                          'Continue',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}
