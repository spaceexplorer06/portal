import 'package:flutter/material.dart';
import 'package:portal/Contact.dart';
import 'package:portal/Intro_page.dart';
import 'package:portal/class_grid.dart';
import 'package:portal/profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const IntroPage(),
      routes: {
        '/home/': (context) => const IntroPage(),
        '/grid/': (context) => const ClassGrid(),
        '/profile/': (context) => const Profile(),
        '/contact/': (context) => const Contact(),
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  List<List<String?>> studentNames = List.generate(10, (_) => List.filled(10, null)); // Example 10x10 grid

  // Method to show input dialog for saving student names
  void _showInputDialog(int row, int col) {
    TextEditingController controller = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Enter Student Name'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Student Name"),
          ),
          actions: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Save'),
              onPressed: () {
                String? name = controller.text.isEmpty ? null : controller.text;
                setState(() {
                  studentNames[row][col] = name; // Update studentNames with the new name
                });
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Admin Login")),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _usernameController,
                decoration: InputDecoration(
                  hintText: "U S E R N A M E",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 231, 196, 196),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: TextField(
                controller: _passwordController,
                obscureText: true, // Hide password input
                decoration: InputDecoration(
                  hintText: "P A S S W O R D",
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(
                      color: Color.fromARGB(255, 231, 196, 196),
                    ),
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                // Simple navigation logic
                Navigator.of(context).pushNamedAndRemoveUntil('/home/', (route) => false);
              },
              child: const Text("Login"),
            ),
            // Example of using the input dialog to save a student's name
            ElevatedButton(
              onPressed: () => _showInputDialog(0, 0), // Open dialog for row 0, column 0
              child: const Text("Add Student"),
            ),
          ],
        ),
      ),
    );
  }
}
