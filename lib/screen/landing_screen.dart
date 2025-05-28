import 'package:flutter/material.dart';

class LandingScreen extends StatefulWidget {
  final void Function() onStart;

  const LandingScreen(this.onStart, {super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with TickerProviderStateMixin {
  late AnimationController _textController;
  late Animation<Offset> _titleOffsetAnimation;
  late Animation<Offset> _subtitleOffsetAnimation;
  late Animation<double> _fadeInAnimation;
  late AnimationController _buttonController;
  late AnimationController _imageController;
  late Animation<double> _imageScaleAnimation;

  @override
  void initState() {
    super.initState();

    _textController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _titleOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _subtitleOffsetAnimation = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _textController,
      curve: Curves.easeOut,
    ));

    _fadeInAnimation = CurvedAnimation(
      parent: _textController,
      curve: Curves.easeIn,
    );

    _buttonController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _imageController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _imageScaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(parent: _imageController, curve: Curves.easeOutBack),
    );

    _textController.forward();
    _imageController.forward();
    _textController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _buttonController.forward();
      }
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    _buttonController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(255, 123, 172, 1),
              Color.fromRGBO(255, 188, 117, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 60), // ⬅️ Increased height
            ScaleTransition(
              scale: _imageScaleAnimation,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Image.asset(
                  'assets/images/meal.jpg',
                  width: double.infinity,
                  height: MediaQuery.of(context).size.height * 0.5,
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 20),
            SlideTransition(
              position: _titleOffsetAnimation,
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: const Text(
                  'Welcome to DeliMeals!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'RobotoCondensed',
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            SlideTransition(
              position: _subtitleOffsetAnimation,
              child: FadeTransition(
                opacity: _fadeInAnimation,
                child: const Text(
                  'Discover delicious meals tailored just for you.\nFilter by your dietary needs and mark your favorites!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    fontFamily: 'Raleway',
                    color: Colors.white70,
                  ),
                ),
              ),
            ),
            const Spacer(),
            FadeTransition(
              opacity: _buttonController,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.pinkAccent,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                icon: const Icon(Icons.fastfood),
                label: const Text(
                  'Get Started',
                  style: TextStyle(fontSize: 18),
                ),
                onPressed: widget.onStart,
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
