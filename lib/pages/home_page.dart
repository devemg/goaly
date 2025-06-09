import 'package:flutter/material.dart';
import 'package:goaly/pages/new_goal_page.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/widgets/goals_list.dart';
import 'package:goaly/widgets/header.dart';
import 'package:goaly/widgets/todays_progress.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
 
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
                    onPressed: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context) => NewGoalPage()));
                    },
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
                children: [Text('Your Goals for Today', style: sectionSubtitleSty), Text('View All', style: linkSty)],
              ),
            ],
          ),
        ),
        GoalsList(),
      ],
    );
  }
}
