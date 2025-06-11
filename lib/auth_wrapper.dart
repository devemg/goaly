import 'package:flutter/material.dart';
import 'package:goaly/app_state.dart';
import 'package:goaly/db/database.dart';
import 'package:goaly/pages/public/root_public_page.dart';
import 'package:goaly/pages/root_page.dart';
import 'package:provider/provider.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<MyAppState>(context);
    if (appState.currentUser == null) {
      return RootPublicPage();
    }
    return FutureBuilder(
      future: DatabaseService.getAllGoals(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        return RootPage();
      },
    );
  }
}