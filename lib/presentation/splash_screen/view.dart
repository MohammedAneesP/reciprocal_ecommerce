import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/main.dart';
import 'package:reciprocal_task/presentation/bottom_nav/bottom_nav.dart';
import 'package:reciprocal_task/presentation/landing%20page/view.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    goto();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(Icons.shopping_bag_sharp, size: 100),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(const Duration(seconds: 3));
    isViewed != 0 ? toLanding() : toHome(); // checking if user is visited once before
  }

  void toLanding() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const LandingPage()));
  }

  void toHome() {
    Navigator.pushReplacement(
        context, CupertinoPageRoute(builder: (context) =>  BottomNav()));
  }
}
