import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/models/user_model.dart';
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
  final user = User(name: 'Emely', email: 'garciam.emm@gmail.com', avatar: 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=M3w0NTYyMDF8MHwxfHNlYXJjaHw0fHx1c2VyfGVufDB8fHx8MTc0ODk5OTI3N3ww&ixlib=rb-4.1.0&q=80&w=1080');
  
  void add(Goal item) {
    _goals.add(item);
    notifyListeners();
  }

}

