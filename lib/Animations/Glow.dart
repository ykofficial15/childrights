import 'package:childrights/App_Zones/Games/Image_Quiz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class GlowingTextAnimation extends StatefulWidget {
  @override
  _GlowingTextAnimationState createState() => _GlowingTextAnimationState();
}

class _GlowingTextAnimationState extends State<GlowingTextAnimation>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    // Initialize Firebase
    Firebase.initializeApp().whenComplete(() {
      // Now you can initialize the animation controller
      _controller = AnimationController(
        vsync: this,
        duration: Duration(seconds: 2),
      )..repeat(reverse: true);

      _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);

      // Set state to rebuild the widget after Firebase is initialized
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null) {
      // Firebase is still initializing, you can show a loading indicator or handle this case differently.
      return CircularProgressIndicator();
    }

    return Column(
      children: [
        Container(
          child: Stack(
            alignment: Alignment.center,
            children: <Widget>[
              // Background glow effect
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Container(
                    width: 200,
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.9 * _animation.value),
                          blurRadius: 50.0 * _animation.value,
                        ),
                      ],
                    ),
                  );
                },
              ),
              // Text
              Text(
                'Image Quiz T&F',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => QuizScreen(),
              ),
            );
          },
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.deepOrange,
            ),
            padding: EdgeInsets.all(5),
            child: Text(
              'Explore',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 13,
        ),
      ],
    );
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller.dispose();
    }
    super.dispose();
  }
}
