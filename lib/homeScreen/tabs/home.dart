import 'package:fikir_milk/auth/signup/signup.dart';
import 'package:fikir_milk/homeScreen/supplier.dart';
import 'package:flutter/material.dart';

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
    SupplierScreen(),
    SignUpScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
          onTap: navigationMenu,
          currentIndex: selectedIndex,
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Supplier List',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Add User',
            ),
          ]),
    );
  }
}
