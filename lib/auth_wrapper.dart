import 'package:flutter/material.dart';
import 'package:goaly/pages/root_page.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
        return RootPage();
    // final appState = Provider.of<MyAppState>(context);
    // if (appState.currentUser == null) {
    //   return RootPublicPage();
    // }
    // return FutureBuilder(
    //   future: DatabaseHelper.getAllGoals(),
    //   builder: (context, snapshot) {
    //     if (snapshot.connectionState == ConnectionState.waiting) {
    //       return const Scaffold(
    //         body: Center(child: CircularProgressIndicator()),
    //       );
    //     }
    //   },
    // );
  }
}