import 'package:flutter/material.dart';
import 'package:portal/Contact.dart';
import 'package:portal/class_grid.dart';
import 'package:portal/profile.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({super.key});

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text('Departments'),
        centerTitle: true,
      ),

      // Drawer for navigation
      drawer: Drawer(
        child: Container(
          color: const Color.fromARGB(255, 255, 122, 122),
          child: ListView(
            children: [
              DrawerHeader(
                child: Column(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Profile()));
                      },
                      icon: const Icon(Icons.person),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Profile",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text("Check Sitting Plan"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                },
              ),
              ListTile(
                leading: const Icon(Icons.contact_phone_sharp),
                title: const Text("Contact Faculty"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context) => const Contact()));
                },
              ),
            ],
          ),
        ),
      ),

      // GestureDetector for opening drawer on swipe
      body: GestureDetector(
        onHorizontalDragEnd: (details) {
          if (details.primaryVelocity != null && details.primaryVelocity! > 0) {
            _scaffoldKey.currentState?.openDrawer();
          }
        },

        // Main Content - Blocks with departments
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView(
            children: [
              // Block 1
              Block(
                blockName: 'Block 1',
                departments: [
                  DepartmentTile(
                    departmentName: 'Engineering',
                    icon: Icons.engineering,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const EngineeringCoursesPage()));
                    },
                  ),
                  DepartmentTile(
                    departmentName: 'Journalism & Mass Communication',
                    icon: Icons.camera_alt,
                    color: Colors.purple,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                    },
                  ),
                  DepartmentTile(
                    departmentName: 'Fashion Designing',
                    icon: Icons.design_services,
                    color: Colors.pink,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                    },
                  ),
                ],
              ),

              // Block 2
              Block(
                blockName: 'Block 2',
                departments: [
                  DepartmentTile(
                    departmentName: 'Chandigarh School of Business',
                    icon: Icons.business,
                    color: Colors.orange,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                    },
                  ),
                ],
              ),

              // Block 3
              Block(
                blockName: 'Block 3',
                departments: [
                  DepartmentTile(
                    departmentName: 'Engineering',
                    icon: Icons.engineering,
                    color: Colors.blue,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                    },
                  ),
                ],
              ),

              // Block 4
              Block(
                blockName: 'Block 4',
                departments: [
                  DepartmentTile(
                    departmentName: 'Chandigarh Law College',
                    icon: Icons.gavel,
                    color: Colors.red,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                    },
                  ),
                ],
              ),

              // Block 5
              Block(
                blockName: 'Block 5',
                departments: [
                  DepartmentTile(
                    departmentName: 'Chandigarh Pharmacy College',
                    icon: Icons.local_pharmacy,
                    color: Colors.green,
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Widget for each block
class Block extends StatelessWidget {
  final String blockName;
  final List<DepartmentTile> departments;

  const Block({
    Key? key,
    required this.blockName,
    required this.departments,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 10.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 6,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              blockName,
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const Divider(),
            ...departments,
          ],
        ),
      ),
    );
  }
}

// Widget for each department inside a block
class DepartmentTile extends StatelessWidget {
  final String departmentName;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const DepartmentTile({
    Key? key,
    required this.departmentName,
    required this.icon,
    required this.color,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: Icon(
        icon,
        color: color,
        size: 40,
      ),
      title: Text(
        departmentName,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        color: Colors.teal,
      ),
    );
  }
}// Ensure ClassGrid is imported for navigation


class EngineeringCoursesPage extends StatefulWidget {
  const EngineeringCoursesPage({super.key});

  @override
  _EngineeringCoursesPageState createState() => _EngineeringCoursesPageState();
}

class _EngineeringCoursesPageState extends State<EngineeringCoursesPage> {
  final List<String> courses = const [
    'B.Tech. CSE (Computer Science Engineering)',
    'B.Tech. AI & ML (Artificial Intelligence & Machine Learning)',
    'B.Tech. AI & DS (Artificial Intelligence & Data Science)',
    'B.Tech. Robotics & AI (Artificial Intelligence)',
    'B.Tech. ECE (Electronics & Communication Engineering)',
    'B.Tech. CE (Civil Engineering)',
    'B.Tech. ME (Mechanical Engineering)',
    'B.Tech. EE (Electrical Engineering)',
    'B.Tech. ETE (Electronics & Telecommunication Engineering)',
    'B.Tech. CSE (Cyber Security)',
    'B.Tech. Blockchain',
    'B.Tech. CSE (Data Science)',
    'B.Tech. CSE (IoT & Cyber Security Including Blockchain Technology)',
    'B.Tech. CSE (LEET)',
    'B.Tech. AI & ML (LEET)',
    'B.Tech. AI & DS (LEET)',
    'B.Tech. Robotics & AI (LEET)',
    'B.Tech. ECE (LEET)',
    'B.Tech. Civil Engineering (LEET)',
    'B.Tech. ME (LEET)',
    'B.Tech. EE (LEET)',
    'B.Tech. ETE (LEET)',
    'B.Tech. CSE Cyber Security (LEET)',
    'B.Tech. Blockchain (LEET)',
  ];

  List<String> filteredCourses = [];
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    filteredCourses = courses; // Initialize filtered list with all courses
  }

  void _filterCourses(String query) {
    final filteredList = courses.where((course) {
      return course.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredCourses = filteredList; // Update the state with the filtered list
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Engineering Courses'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search bar for filtering courses
            TextField(
              controller: _searchController,
              onChanged: _filterCourses, // Call the filter method on input change
              decoration: InputDecoration(
                hintText: 'Search for a course...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            const SizedBox(height: 16.0), // Space between search bar and course list
            Expanded(
              child: ListView.builder(
                itemCount: filteredCourses.length,
                itemBuilder: (context, index) {
                  return CourseCard(courseName: filteredCourses[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Card widget for displaying each course
class CourseCard extends StatelessWidget {
  final String courseName;

  const CourseCard({Key? key, required this.courseName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          courseName,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.teal,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward,
          color: Colors.teal,
        ),
        onTap: () {
          // Navigate to the grid view for filling exam info
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => const ClassGrid()));
        },
      ),
    );
  }
}
