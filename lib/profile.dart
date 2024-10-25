import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Teacher Profile'),
        backgroundColor: Colors.teal,
        elevation: 6.0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile Picture Section
            Center(
              child: CircleAvatar(
                radius: 70,
                backgroundImage: const AssetImage('assets/teacher.jpg'), // Replace with your image path
                backgroundColor: Colors.grey.shade200,
              ),
            ),
            const SizedBox(height: 16),

            // Teacher's Name
            const Text(
              'Moinak Dey',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 8),

            // Subject Specialization
            const Text(
              'AI Researcher',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Details
            Expanded(
              child: ListView(
                children: [
                  // Contact Information
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.email, color: Colors.teal),
                      title: Text('Email'),
                      subtitle: Text('moinakdey21@gmail.com'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Phone Number
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.phone, color: Colors.teal),
                      title: Text('Phone'),
                      subtitle: Text('9123811801'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Address
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const ListTile(
                      leading: Icon(Icons.location_on, color: Colors.teal),
                      title: Text('Address'),
                      subtitle: Text('CGC Jhanjeri, Mohali'),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // About/Bio Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'About',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Moinak Dey specializes in AI researcher and is currently working on a new neural model.',
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}