import 'package:flutter/material.dart';
import 'package:goaly/widgets/goals_log_list.dart';

class ProgressPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    spacing: 10,
                    children: [
                      Text('68%'),
                      Text('Overall Progress'),
                      LinearProgressIndicator(
                        value: 0.5,
                        minHeight: 10,
                        borderRadius: BorderRadiusGeometry.all(
                          Radius.circular(100),
                        ),
                        semanticsLabel: 'Linear progress indicator',
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Column(children: [Text('15'), Text('Completed')]),
                          Column(children: [Text('7'), Text('In Progress')]),
                          Column(children: [Text('3'), Text('Overdue')]),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Text('Recent Activity'),
            ],
          ),
        ),
        GoalsLogList(),
      ],
    );
  }
}
