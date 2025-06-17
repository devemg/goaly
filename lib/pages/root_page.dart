import 'package:flutter/material.dart';
import 'package:goaly/pages/calendar_page.dart';
import 'package:goaly/pages/profile_page.dart';
import 'package:goaly/pages/progress_page.dart';

class RootPage extends StatefulWidget {
  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            icon: Icon(Icons.area_chart),
            label: 'Progress',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month),
            label: 'Calendar',
          ),
          NavigationDestination(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        top: true,
        child: <Widget>[
          // HomePage(),
          ProgressPage(),
          CalendarPage(),
          ProfilePage(),
        ][currentPageIndex],
      ),
    );
  }
}
