import 'package:flutter/material.dart';
import 'package:reciprocal_task/presentation/login_signin/login_page/view.dart';

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
        child: Icon(Icons.shopping_bag_sharp, size: 50),
      ),
    );
  }

  Future<void> goto() async {
    await Future.delayed(const Duration(seconds: 3));
    toHome();
  }

  void toHome() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => LoginPage()));
  }
}
