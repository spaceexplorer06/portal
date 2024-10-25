import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Faculty',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Contact(),
    );
  }
}

class Contact extends StatefulWidget {
  const Contact({super.key});

  @override
  State<Contact> createState() => _ContactState();
}

class _ContactState extends State<Contact> {
  final List<ContactInfo> contacts = [
    ContactInfo(name: "Dr. Alice Smith", title: "Campus Director", email: "alice.smith@university.edu", phone: "1234567890"),
    ContactInfo(name: "Prof. John Doe", title: "Dean", email: "john.doe@university.edu", phone: "2345678901"),
    ContactInfo(name: "Dr. Sarah Johnson", title: "HOD - Computer Science", email: "sarah.johnson@university.edu", phone: "3456789012"),
    ContactInfo(name: "Dr. Michael Brown", title: "HOD - Electrical Engineering", email: "michael.brown@university.edu", phone: "4567890123"),
    ContactInfo(name: "Dr. Emma Davis", title: "HOD - Mechanical Engineering", email: "emma.davis@university.edu", phone: "5678901234"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Padding(
          padding: EdgeInsets.all(20.0),
          child: Text("Contact Faculty"),
        ),
      ),
      body: ListView.builder(
        itemCount: contacts.length,
        itemBuilder: (context, index) {
          return ContactCard(contact: contacts[index]);
        },
      ),
    );
  }
}

class ContactInfo {
  final String name;
  final String title;
  final String email;
  final String phone;

  ContactInfo({
    required this.name,
    required this.title,
    required this.email,
    required this.phone,
  });
}

class ContactCard extends StatelessWidget {
  final ContactInfo contact;

  const ContactCard({Key? key, required this.contact}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          contact.name,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contact.title, style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 4.0),
            Text('Email: ${contact.email}'),
            Text('Phone: ${contact.phone}'),
          ],
        ),
        isThreeLine: true,
        trailing: IconButton(
          icon: const Icon(Icons.contact_phone),
          onPressed: () {
            _showContactOptions(context, contact);
          },
        ),
      ));
    }
  
  void _showContactOptions(BuildContext context, ContactInfo contact) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Contact ${contact.name}',
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Send Email'),
                onTap: () {
                  Navigator.pop(context);
                  _sendEmail(contact.email);
                },
              ),
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Call'),
                onTap: () async {
                  Navigator.pop(context);
                  await _makePhoneCall(contact.phone);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _makePhoneCall(String phoneNumber) async {
    String cleanedNumber = phoneNumber.replaceAll(RegExp(r'[^0-9]'), '');
    print('Cleaned Phone Number: $cleanedNumber');

    final Uri launchUri = Uri(
      scheme: 'tel',
      path: cleanedNumber,
    );

    if (await Permission.phone.request().isGranted) {
      try {
        if (await canLaunchUrl(launchUri)) {
          await launchUrl(launchUri);
        } else {
          print('Could not launch: $launchUri');
        }
      } catch (e) {
        print('Error launching dialer: $e');
      }
    } else {
      print('Phone call permission not granted.');
    }
  }

  Future<void> _sendEmail(String email) async {
    final Uri launchUri = Uri(
      scheme: 'mailto',
      path: email,
      query: encodeQueryParameters({
        'subject': 'Hello',
        'body': 'I would like to discuss...',
      }),
    );

    print('Email URI: $launchUri');

    try {
      if (await canLaunchUrl(launchUri)) {
        await launchUrl(launchUri);
      } else {
        print('Could not launch email client. Check if an email app is installed.');
      }
    } catch (e) {
      print('Error launching email client: $e');
    }
  }

  String encodeQueryParameters(Map<String, String> params) {
    return params.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
  }
}
