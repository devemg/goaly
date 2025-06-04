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
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
          child: Column(
            spacing: 10,
            children: [
              Row(
                children: [
                  FilledButton.icon(
                    label: Text('Add Goal'),
                    icon: Icon(Icons.add),
                    onPressed: () {},
                  ),
                  SizedBox(width: 10),
                  FilledButton.tonalIcon(
                    label: Text('View Stats'),
                    icon: Icon(Icons.stacked_bar_chart_outlined),
                    onPressed: () {},
                  ),
                ],
              ),
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Text('Your Goals'), Text('View All')],
              ),
            ],
          ),
        ),
        GoalsList(showActions: true),
      ],
    );
  }
}
