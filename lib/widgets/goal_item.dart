import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';

class GoalItem extends StatelessWidget {
  final Goal goalItem;
  const GoalItem({super.key, required this.goalItem});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Text(goalItem.title, textAlign: TextAlign.left),
                  Text(goalItem.description, textAlign: TextAlign.left),
                  Row(children: [Text(goalItem.status)]),
                ],
              ),
            ],
          ),
        ),
      );
  }
}
