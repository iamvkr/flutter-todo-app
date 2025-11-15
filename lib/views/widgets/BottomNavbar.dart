import 'package:flutter/material.dart';
import 'package:todo_app/data/notifiers.dart';

class BottomNavbar extends StatefulWidget {
  const BottomNavbar({super.key});

  @override
  State<BottomNavbar> createState() => _BottomNavbarState();
}

class _BottomNavbarState extends State<BottomNavbar> {
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
      destinations: [
        NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
        NavigationDestination(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      selectedIndex: navIndexNotifier.value,
      onDestinationSelected: (value) {
        print(value);
        setState(() {
          navIndexNotifier.value = value;
        });
      },
    );
  }
}
