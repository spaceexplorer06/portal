import 'package:flutter/material.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  bool isEditing = false;

  // Text controllers for profile fields
  final TextEditingController nameController = TextEditingController(text: 'Moinak Dey');
  final TextEditingController specializationController = TextEditingController(text: 'AI Researcher');
  final TextEditingController emailController = TextEditingController(text: 'moinakdey21@gmail.com');
  final TextEditingController phoneController = TextEditingController(text: '9123811801');
  final TextEditingController addressController = TextEditingController(text: 'CGC Jhanjeri, Mohali');
  final TextEditingController aboutController = TextEditingController(
      text: 'Moinak Dey specializes in AI research and is currently working on a new neural model.');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.teal,
        elevation: 6.0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(isEditing ? Icons.save : Icons.edit),
            onPressed: () {
              setState(() {
                isEditing = !isEditing; // Toggle editing mode
              });
            },
          ),
        ],
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

            // Editable Teacher's Name
            TextFormField(
              controller: nameController,
              enabled: isEditing,
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 8),

            // Editable Subject Specialization
            TextFormField(
              controller: specializationController,
              enabled: isEditing,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
            ),
            const SizedBox(height: 20),

            // Profile Details
            Expanded(
              child: ListView(
                children: [
                  // Editable Contact Information
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.email, color: Colors.teal),
                      title: const Text('Email'),
                      subtitle: TextFormField(
                        controller: emailController,
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Editable Phone Number
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.phone, color: Colors.teal),
                      title: const Text('Phone'),
                      subtitle: TextFormField(
                        controller: phoneController,
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Editable Address
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: ListTile(
                      leading: const Icon(Icons.location_on, color: Colors.teal),
                      title: const Text('Address'),
                      subtitle: TextFormField(
                        controller: addressController,
                        enabled: isEditing,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),

                  // Editable About/Bio Section
                  Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'About',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.teal,
                            ),
                          ),
                          const SizedBox(height: 10),
                          TextFormField(
                            controller: aboutController,
                            enabled: isEditing,
                            maxLines: null,
                            style: const TextStyle(fontSize: 16),
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                            ),
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
