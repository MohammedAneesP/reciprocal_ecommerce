import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:reciprocal_task/firebase_options.dart';
import 'package:reciprocal_task/presentation/splash_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed ;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  SharedPreferences preference = await SharedPreferences.getInstance();
  isViewed = preference.getInt("Landed");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}
