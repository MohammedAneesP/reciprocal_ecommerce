import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/presentation/bottom_nav/bottom_nav.dart';
import 'package:reciprocal_task/widgets/utils.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirebaseAuthMethods {
  final FirebaseAuth anFireAuth;
  FirebaseAuthMethods({required this.anFireAuth});

  Future<void> signUpWithEmail({
    required String anEmail,
    required String anPassword,
    required BuildContext context,
  }) async {
    try {
      await anFireAuth.createUserWithEmailAndPassword(
          email: anEmail, password: anPassword);
      if (context.mounted) {
        await sendVerification(context);
        if (context.mounted) {
          Navigator.pop(context);
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        anSnackBarFunc(
            context: context, aText: e.message.toString(), anColor: kRed);
      }
    }
  }

  Future<void> loginWithEmailPassword(
      {required String anEmail,
      required String anPassword,
      required BuildContext context}) async {
    try {
      await anFireAuth.signInWithEmailAndPassword(
          email: anEmail, password: anPassword);
      if (!anFireAuth.currentUser!.emailVerified) {
        if (context.mounted) {
          await sendVerification(context);
        }
      } else {
        if (context.mounted) {
          landingPageHandle();
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(
              builder: (context) => BottomNav(),
            ),
          );
        }
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        anSnackBarFunc(
            context: context, aText: e.message.toString(), anColor: kRed);
      }
    }
  }

  Future<void> forgotPassword(
      {required String anEmail, required BuildContext context}) async {
    try {
      await anFireAuth.sendPasswordResetEmail(email: anEmail);
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        anSnackBarFunc(
            context: context, aText: e.message.toString(), anColor: kRed);
      }
    }
  }

  Future<void> sendVerification(BuildContext context) async {
    try {
      await anFireAuth.currentUser!.sendEmailVerification();
      if (context.mounted) {
        anSnackBarFunc(
            context: context,
            aText: "please verify before login",
            anColor: kBlue);
      }
    } on FirebaseAuthException catch (e) {
      if (context.mounted) {
        anSnackBarFunc(
            context: context, aText: e.message.toString(), anColor: kRed);
      }
    }
  }

  landingPageHandle() async {
    int isViewed = 0;
    SharedPreferences anPreference = await SharedPreferences.getInstance();
    anPreference.setInt("Landed", isViewed);
  }
}
