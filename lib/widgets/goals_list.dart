import 'package:flutter/material.dart';

class GoalsList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: 11,
        padding: EdgeInsets.symmetric(horizontal: 10),
        itemBuilder: (context, index) {
          if (index == 0) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
            );
          }

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
    // return ListView.builder(
    //   itemCount: items.length,
    //   prototypeItem: ListTile(title: Text(items.first)),
    //   itemBuilder: (context, index) {
    //     return ListTile(title: Text(items[index]));
    //   },
    // children: [
    //   Padding(
    //     padding: const EdgeInsets.symmetric(horizontal: 10),
    //     child: ,
    //   ),

    //   for (int i = 0; i < 5; i++)

    // ],
    // );
  }
}
