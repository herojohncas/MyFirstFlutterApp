import 'package:flutter/material.dart';
import 'profile.dart';
import 'homepage.dart';
import 'personal_info.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
        iconTheme: IconThemeData(
          color: Colors.white,
        ), // Change drawer icon color to white
        centerTitle: true,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text('Oflutter.com'),
              accountEmail: Text('example@gmail.com'),
              currentAccountPicture: CircleAvatar(
                child: ClipOval(
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage('images/profile-bg3.jpg'),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Navigator.pop(context); // Stay on dashboard
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Add navigation to ProfilePage
                // Navigate to the ProfilePage
                // If ProfilePage is already in the stack, this will bring it to the front.
                // If not, it will push a new instance.
                Navigator.pop(context); // Close the drawer first
                Navigator.pushReplacement(
                  // Use pushReplacement to avoid stacking multiple dashboards
                  context,
                  MaterialPageRoute(builder: (context) => ProfilePage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Personal Info'),
              onTap: () {
                // Navigate back to the LoginPage and remove all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => PersonalInfoPage()),
                  (Route<dynamic> route) =>
                      false, // This predicate removes all routes
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.exit_to_app),
              title: Text('Exit'),
              onTap: () {
                // Navigate back to the LoginPage and remove all previous routes
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => HomePage()),
                  (Route<dynamic> route) =>
                      false, // This predicate removes all routes
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
        // Center the content in the body
        child: Padding(
          padding: const EdgeInsets.all(
            16.0,
          ), // Add some padding around the content
          child: Text(
            'Welcome to the Dashboard!', // Text to display in the body
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center, // Center the text itself
          ),
        ),
      ),
    );
  }
}
