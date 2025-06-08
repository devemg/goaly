import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:provider/provider.dart';

class GoalsList extends StatelessWidget {

  const GoalsList({super.key});

  @override
  Widget build(BuildContext context) {

    return Consumer<MyAppState>(builder: (context, state, child) {
      return Expanded(
      child: ListView.builder(
        itemCount: state.goals.length,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          final currentGoal = state.goals[index];
          return GestureDetector(
            onTap: (){
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
    });
  }
}
