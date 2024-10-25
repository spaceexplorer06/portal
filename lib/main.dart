import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:portal/Contact.dart';
import 'package:portal/Intro_page.dart';
import 'package:portal/Landing.dart';
import 'package:portal/class_grid.dart';
import 'package:portal/profile.dart';

void main() {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState(){
    super.initState();
    initialization();
  }
  void initialization()async{
    print('Pausing');
    await Future.delayed(const Duration(seconds: 1));
    print('Unpausing');
    FlutterNativeSplash.remove();
  }
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LandingScreen(), // Set LandingScreen as the home
      routes: {
        '/home/': (context) => const IntroPage(),
        '/grid/': (context) => const ClassGrid(),
        '/profile/': (context) => const Profile(),
        '/contact/': (context) => const Contact(),
      },
    );
  }
}
