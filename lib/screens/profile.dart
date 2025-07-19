// lib/profile_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard.dart' show DashboardPage;

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Center(child: Text('Profile', style: TextStyle(color: Colors.white),)),
        backgroundColor: Colors.teal,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const DashboardPage()), // Navigate to DashboardScreen
            );
          },
        ),
        actions: [
          SizedBox(width: 56), // Placeholder to balance the leading icon if there's no title
        ],
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: <Widget>[
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                Container(
                  height: 220,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/profile-bg3.jpg'),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Positioned(
                  bottom: -60.0,
                  child: CircleAvatar(
                    radius: 70,
                    backgroundImage: AssetImage('images/profile.jpg'),
                  ),
                ),
              ],
            ),
            SizedBox(height: 60),
            Text(
              'Hero John Cas',
              style: TextStyle(
                fontFamily: 'Pacifico',
                fontSize: 40.0,
                color: Colors.teal,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'WEB DEVELOPER',
              style: TextStyle(
                fontFamily: 'Source Code Pro',
                color: Colors.teal.shade700,
                fontSize: 15.0,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 20.0,
              width: 150.0,
              child: Divider(color: Colors.teal.shade100, thickness: 2.0),
            ),
            Container(
              constraints: BoxConstraints(maxWidth: 400),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  'I’m a full-stack developer with experience in both front-end and back-end development. I’ve worked with Node.js for building server-side applications and React JS for creating interactive user interfaces. My database knowledge includes relational systems like SQL and NoSQL solutions such as MongoDB and Elasticsearch. I also have minor experience with Kotlin and enjoy learning how different technologies work together to build scalable, efficient applications. Currently, I’m expanding my skill set by diving into Flutter to create cross-platform apps with modern UI and smooth performance.',
                  style: TextStyle(
                    fontSize: 16,
                    height: 1.5,
                    color: Colors.black87,
                  ),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'CONTACT DETAILS',
              style: TextStyle(
                fontFamily: 'Source Code Pro',
                color: Colors.teal.shade700,
                fontSize: 15.0,
                letterSpacing: 1,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 30.0,
              width: 150.0,
              child: Divider(color: Colors.teal.shade100, thickness: 2.0),
            ),
            ContactCard(
              icon: Icons.phone,
              label: '+639464346116',
              uri: Uri.parse('tel:+639464346116'),
            ),
            ContactCard(
              icon: Icons.email,
              label: 'herocas62@gmail.com',
              uri: Uri.parse('mailto:herocas62@gmail.com'),
            ),
            ContactCard(
              icon: Icons.facebook,
              label: 'https://www.facebook.com/HeroEmsEj',
              uri: Uri.parse('https://facebook.com/heroemsej'),
            ),
            // Example button to trigger autoscroll
            // ElevatedButton(
            //   onPressed: _scrollToBottom,
            //   child: Text('Scroll to Bottom'),
            // )
            SizedBox(height: 100.0),
          ],
        ),
      ),
    );
  }
}

class ContactCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Uri uri;

  const ContactCard({
    required this.icon,
    required this.label,
    required this.uri,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 400),
      width: double.infinity,
      child: Card(
        color: Colors.teal,
        // margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          onTap: () async {
            await launchUrl(uri, mode: LaunchMode.externalApplication);
          },
          leading: Icon(icon, color: Colors.white),
          title: Text(label, style: TextStyle(color: Colors.white)),
        ),
      ),
    );
  }
}
