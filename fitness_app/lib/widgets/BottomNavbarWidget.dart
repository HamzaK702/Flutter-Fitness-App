import 'package:flutter/material.dart';

class CustomBottomNavigationBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  CustomBottomNavigationBar({required this.selectedIndex, required this.onItemTapped});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.black,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Color(0xFFF2FF00),
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home_outlined),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person_outline),
          label: 'Profile',
        ),
      ],
      currentIndex: selectedIndex,
      onTap: onItemTapped,
      selectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
      unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w200),
      elevation: 8.0,
    );
  }
}
