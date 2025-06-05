import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';

class GoalsList extends StatelessWidget {
  final List<Goal> goals;
  final ValueChanged<String> onChanged;

  const GoalsList({super.key, required this.goals, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: goals.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final currentGoal = goals[index];
          return GestureDetector(
            onTap: (){
              onChanged(currentGoal.id);
            },
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.check),
                    SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(currentGoal.title, textAlign: TextAlign.left),
                        Text(currentGoal.description, textAlign: TextAlign.left),
                        Row(
                          children: [
                            Text(currentGoal.status),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
