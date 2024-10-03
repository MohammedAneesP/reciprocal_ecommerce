import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/constants/textstyle_const.dart';
import 'package:reciprocal_task/presentation/bottom_nav/bottom_nav.dart';
import 'package:reciprocal_task/presentation/home_screen/view.dart';
import 'package:reciprocal_task/presentation/login_signin/login_page/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  landingPageHandle() async {
    int isViewed = 0;
    SharedPreferences anPreference = await SharedPreferences.getInstance();
    anPreference.setInt("Landed", isViewed);
  }

  @override
  Widget build(BuildContext context) {
    final kHeight = MediaQuery.sizeOf(context);
    final kWidth = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () async {
              landingPageHandle();
              Navigator.pushReplacement(
                context,
                CupertinoPageRoute(
                  builder: (context) => const BottomNav(),
                ),
              );
            },
            child: const Text(
              "Skip ",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold,color: kBlue),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: kHeight.height * 0.1),
          const Text(
            "Welcome to Shoppie App",
            style: loginTitle,
          ),
          Container(
            height: kHeight.height * 0.5,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/pngwing.com.png"))),
          ),
          OutlinedButton(
              style: ElevatedButton.styleFrom(
                fixedSize: Size(kWidth.width * 0.45, 50)
              ),
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  CupertinoPageRoute(
                    builder: (context) => LoginPage(),
                  ),
                );
              },
              child: const Text("Sign In",style: buttontextBlack,))
        ],
      ),
    );
  }
}
