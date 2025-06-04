import 'package:flutter/material.dart';
import 'package:goaly/widgets/goals_list.dart';
import 'package:goaly/widgets/header.dart';
import 'package:goaly/widgets/todays_progress.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Header(),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: TodaysProgress(),
        ),
        GoalsList()
      ],
    );
  }
}
