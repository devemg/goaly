
import 'package:flutter/material.dart';

class TodaysProgress extends StatelessWidget {
  const TodaysProgress({
    super.key,
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
                Text('68%')
              ],
            ),
            LinearProgressIndicator(
              value: 0.5,
              minHeight: 10,
              borderRadius: BorderRadiusGeometry.all(Radius.circular(100)),
              semanticsLabel: 'Linear progress indicator',
            ),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("5 of 7 goals completed"),
                Text('2 remaining')
              ],
            )
          ],
        ),
      ),
    );
  }
}
