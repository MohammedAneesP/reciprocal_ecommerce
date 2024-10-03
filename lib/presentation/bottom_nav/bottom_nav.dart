import 'package:flutter/material.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/presentation/cart_screen/cart_screen.dart';
import 'package:reciprocal_task/presentation/home_screen/view.dart';
import 'package:reciprocal_task/presentation/orders_screen/view.dart';
import 'package:reciprocal_task/presentation/profile_screeen/view.dart';

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int selectedIndex = 0;
  final List<Icon> iconList = [
    const Icon(Icons.home),
    const Icon(Icons.shopping_cart),
    const Icon(Icons.shopping_bag),
    const Icon(Icons.person),
  ];
  @override
  Widget build(BuildContext context) {
    final screens = [
      const HomeScreen(),
      const CartScreen(),
      const OrdersScreen(),
      const ProfileScreen(),
    ];

    void onItemTapped(int index) {
      setState(() {
        selectedIndex = index;
      });
    }

    return Scaffold(
      body: screens[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: kBlue,
        unselectedItemColor: kBlack,
        backgroundColor: kGrey200,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        onTap: onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: iconList[0],
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: iconList[1],
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: iconList[2],
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: iconList[3],
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
