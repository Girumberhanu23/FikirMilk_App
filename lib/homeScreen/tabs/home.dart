import 'package:fikir_milk/auth/signup/signup.dart';
import 'package:fikir_milk/const.dart';
import 'package:fikir_milk/homeScreen/data/homeDataSource.dart';
import 'package:fikir_milk/homeScreen/data/homeRepository.dart';
import 'package:fikir_milk/homeScreen/tabs/supplier.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class HomeScreen extends StatefulWidget {
  HomeScreen({required this.selectedIndex, super.key});

  int selectedIndex;

  @override
  State<HomeScreen> createState() =>
      _HomeScreenState(selectedIndex: selectedIndex);
}

class _HomeScreenState extends State<HomeScreen> {
  _HomeScreenState({required this.selectedIndex});
  int selectedIndex = 0;
  void navigationMenu(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    SupplierScreen(homeRepository: HomeRepository(HomeDataSource())),
    SignUpScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: navigationMenu,
        currentIndex: selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Supplier List',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Add User',
          ),
        ],
        unselectedFontSize: 22,
        selectedFontSize: 22,
        selectedItemColor: btn_color,
        unselectedItemColor: dark_gray,
        iconSize: 40,
      ),
    );
  }
}
