import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/bottom_nav/bottom_nav_index_bloc.dart';
import 'package:reciprocal_task/appliation/cart_listing/cart_listing_bloc.dart';
import 'package:reciprocal_task/appliation/orders/orders_bloc.dart';
import 'package:reciprocal_task/appliation/show_products/show_all_products_bloc.dart';
import 'package:reciprocal_task/firebase_options.dart';
import 'package:reciprocal_task/presentation/address_checkout/checkout.dart';
import 'package:reciprocal_task/presentation/splash_screen/view.dart';
import 'package:shared_preferences/shared_preferences.dart';

int? isViewed;

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
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => BottomNavIndexBloc()),
        BlocProvider(create: (context) => ShowAllProductsBloc()),
        BlocProvider(create: (context) => CartListingBloc()),
        BlocProvider(create: (context) => OrdersBloc()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
       
          useMaterial3: true,
          primarySwatch: Colors.grey,
          scaffoldBackgroundColor: Colors.grey[200],
        ),
        debugShowCheckedModeBanner: false,
        home: const SplashScreen(),
      ),
    );
  }
}
