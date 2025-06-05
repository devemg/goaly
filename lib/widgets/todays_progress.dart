
import 'package:flutter/material.dart';

class TodaysProgress extends StatelessWidget {
  final int total;
  final int completed;
  const TodaysProgress({
    super.key,
    required this.total,
    required this.completed
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
                Text('${(total > 0 ? completed * 100 / total : 0).truncate()}%')
              ],
            ),
            LinearProgressIndicator(
              value: (total > 0 ? completed / total : 0),
              minHeight: 10,
              borderRadius: BorderRadiusGeometry.all(Radius.circular(100)),
              semanticsLabel: 'Linear progress indicator',
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$completed of $total goals completed"),
                Text('${total - completed} remaining')
              ],
            )
          ],
        ),
      ),
    );
  }
}
