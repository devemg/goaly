import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/root_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MyAppState(),
      child: MaterialApp(
        title: 'Goaly',
        theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
        ),
        home: RootPage(),
      ),
    );
  }
}

class MyAppState extends ChangeNotifier {
  final List<Goal> _goals = [];
  UnmodifiableListView<Goal> get goals => UnmodifiableListView(_goals);
  int get completedGoals => _goals.where((g) => g.status == 'completed').length;

  void add(Goal item) {
    _goals.add(item);
    notifyListeners();
  }

}

