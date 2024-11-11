import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({Key? key}) : super(key: key);

  @override
  _LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideUpAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the AnimationController
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    // Define the fade animation
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    // Define the slide-up animation
    _slideUpAnimation = Tween<Offset>(
      begin: const Offset(0, 1), // Start from off-screen
      end: Offset.zero,          // End at its final position
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start the animations
    _animationController.forward();
  }

  @override
  void dispose() {
    // Dispose of the animation controller
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "WELCOME",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF00C6FF), Color(0xFF0072FF)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: FadeTransition(
            opacity: _fadeAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Pulsing animated icon
                AnimatedBuilder(
                  animation: _animationController,
                  builder: (_, child) {
                    return Transform.scale(
                      scale: 1.0 + 0.03 * _animationController.value,
                      child: child,
                    );
                  },
                  child: Icon(
                    Icons.school_rounded,
                    color: Colors.white,
                    size: 100,
                    shadows: [
                      Shadow(
                        blurRadius: 15.0,
                        color: Colors.blueAccent.withOpacity(0.5),
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),

                // Slide-up text with shadow
                SlideTransition(
                  position: _slideUpAnimation,
                  child: const Text(
                    'Welcome to the Student Portal!',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      shadows: [
                        Shadow(
                          blurRadius: 12.0,
                          color: Colors.black45,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                Text(
                  'EXAM SITTING PLAN',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white.withOpacity(0.85),
                    letterSpacing: 1.5,
                  ),
                ),
                const SizedBox(height: 40),

                // Stylish button with glossy effect
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacementNamed('/home/');
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18, horizontal: 50),
                    backgroundColor: Colors.white.withOpacity(0.9),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    shadowColor: Colors.black38,
                    elevation: 10,
                  ),
                  child: const Text(
                    'Get Started',
                    style: TextStyle(
                      color: Color(0xFF0072FF),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
