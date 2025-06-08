import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:provider/provider.dart';

class TodaysProgress extends StatelessWidget {
  const TodaysProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<MyAppState>(
          builder: (context, state, child) {
            return Column(
              spacing: 10,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Today's Progress"),
                    Text(
                      '${(state.goals.isNotEmpty ? state.completedGoals * 100 / state.goals.length : 0).truncate()}%',
                    ),
                  ],
                ),
                LinearProgressIndicator(
                  value: (state.goals.isNotEmpty
                      ? state.completedGoals * 100 / state.goals.length
                      : 0),
                  minHeight: 10,
                  borderRadius: BorderRadiusGeometry.all(Radius.circular(100)),
                  semanticsLabel: 'Linear progress indicator',
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("${state.completedGoals} of ${state.goals.length} goals completed"),
                    Text('${state.goals.length - state.completedGoals} remaining'),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
