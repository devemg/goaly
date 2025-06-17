import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';

class TodaysProgress extends StatelessWidget {
  final List<Goal> goals;
  final int completedGoals;
  const TodaysProgress({
    super.key,
    required this.goals,
    required this.completedGoals,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          spacing: 10,
          children: [
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Progress"),
                Text(
                  '${(goals.isNotEmpty ? completedGoals * 100 / goals.length : 0).truncate()}%',
                ),
              ],
            ),
            LinearProgressIndicator(
              value: (goals.isNotEmpty
                  ? completedGoals * 100 / goals.length
                  : 0),
              minHeight: 10,
              borderRadius: BorderRadiusGeometry.all(Radius.circular(100)),
              semanticsLabel: 'Linear progress indicator',
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$completedGoals of ${goals.length} goals completed"),
                Text('${goals.length - completedGoals} remaining'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
