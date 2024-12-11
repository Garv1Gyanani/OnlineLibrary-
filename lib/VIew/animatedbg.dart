
import 'package:flutter/material.dart';

class PulsingGradientBackground extends StatefulWidget {
  const PulsingGradientBackground({Key? key}) : super(key: key);

  @override
  _PulsingGradientBackgroundState createState() =>
      _PulsingGradientBackgroundState();
}

class _PulsingGradientBackgroundState
    extends State<PulsingGradientBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true); // Repeats the animation infinitely with reverse

    // Create an animation to make the gradient pulse
    _animation = Tween<double>(begin: 1.0, end: 1.5).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut, // Smooth pulsing effect
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: RadialGradient(
              center: Alignment.center,
              radius: _animation.value, // Dynamically change the radius for pulsing
              colors: [
                const Color.fromARGB(255, 32, 1, 42),
                const Color.fromARGB(255, 32, 1, 42),
                const Color.fromARGB(255, 1, 7, 26), // Dark background for the page
                const Color.fromARGB(255, 1, 7, 26), // Dark background for the page
              ],
              stops: [
                0.0,
                0.3,
                0.7,
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}
