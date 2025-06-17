import 'package:flutter/material.dart';
import 'package:goaly/pages/goals/goals_screen.dart';
import 'package:goaly/providers/goal_provider.dart';
import 'package:goaly/providers/reminder_provider.dart';
import 'package:goaly/styles/theme.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      // create: (context) {
      //   return MyAppState();
      // },
      providers: [
        ChangeNotifierProvider(create: (_) => GoalProvider()..loadGoals()),
        ChangeNotifierProvider(create: (_) => ReminderProvider()),
      ],
      child: MaterialApp(
        title: 'Goaly',
        theme: getAppTheme(),
        home:  const GoalsScreen()//AuthWrapper(),
      ),
    );
  }
}
