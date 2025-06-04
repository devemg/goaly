import 'package:flutter/material.dart';

class GoalsLogList extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 11,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
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
                      Text('Morning Workout', textAlign: TextAlign.left),
                      Text(
                        'Complete 60 mins cardio Session',
                        textAlign: TextAlign.left,
                      ),
                      Row(
                        children: [
                          Text('Completed'),
                          SizedBox(width: 10),
                          Text('7:30 AM'),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
