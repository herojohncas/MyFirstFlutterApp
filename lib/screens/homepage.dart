import 'package:flutter/material.dart';
import '/screens/dashboard.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _formKey = GlobalKey<FormState>();


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
                      'Hi there, I’m Hero. This Flutter page reflects my growing expertise in mobile development, modular architecture, and UI/UX design.',
                      style: TextStyle(fontSize: 18, height: 1.5),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 30.0),
                    // Continue Button
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => DashboardPage()),
                          );
                        },
                        child: Text(
                          'Get Started',
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
}
