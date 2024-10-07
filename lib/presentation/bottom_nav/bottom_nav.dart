import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/bottom_nav/bottom_nav_index_bloc.dart';
import 'package:reciprocal_task/constants/colors.dart';
import 'package:reciprocal_task/presentation/cart/cart_screen.dart';
import 'package:reciprocal_task/presentation/home_screen/view.dart';
import 'package:reciprocal_task/presentation/orders_screen/view.dart';
import 'package:reciprocal_task/presentation/profile_screeen/view.dart';

class BottomNav extends StatelessWidget {
  BottomNav({super.key});

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
      CartScreen(),
       OrdersScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: BlocBuilder<BottomNavIndexBloc, BottomNavIndexState>(
        builder: (context, state) {
          int currentIndex = 0;

          if (state is TheIndex) {
            currentIndex = state.currentIndex;
          }

          return screens[currentIndex];
        },
      ),
      bottomNavigationBar: BlocBuilder<BottomNavIndexBloc, BottomNavIndexState>(
        builder: (context, state) {
          int currentIndex = 0;

          if (state is TheIndex) {
            currentIndex = state.currentIndex;
          }
          return BottomNavigationBar(
            
            selectedItemColor: kBlue,
            unselectedItemColor: kBlack,
            backgroundColor: kGrey200,
            currentIndex: currentIndex,
            type: BottomNavigationBarType.fixed,
            onTap: (value) {
              BlocProvider.of<BottomNavIndexBloc>(context)
                  .add(ChangeIndex(anIndex: value));
            },
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
          );
        },
      ),
    );
  }
}
