import 'package:chat/screens/welcome_screen.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static String id = 'splash_screen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation animation;
  late Animation animationColor;
  @override
  void initState() {
    getroute();
    // TODO: implement initState
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 3));
    animation = CurvedAnimation(parent: controller, curve: Curves.decelerate);
    controller.forward();
    animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        controller.reverse(from: 1.0);
      } else if (status == AnimationStatus.dismissed) {
        controller.forward();
      }
    });
    animationColor =
        ColorTween(begin: Colors.white, end: Colors.blue).animate(controller);
    controller.addListener(() {
      setState(() {
        //  print(animation.value);
      });
    });
    super.initState();
  }

  getroute() async {
    await Future.delayed(Duration(seconds: 9), () {
      Navigator.pushNamed(context, WelcomeScreen.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber,
      body: Center(
        child: Row(
          children: [
            Icon(
              Icons.bookmark,
              color: Colors.amber,
              size: animation.value * 60,
            ),
            SizedBox(
              width: 15,
            ),
            Flexible(
              child: Text(
                'WELCOME',
                style: TextStyle(
                  fontSize: 60,
                  fontWeight: FontWeight.bold,
                  color: animationColor.value,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
