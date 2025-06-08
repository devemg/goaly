import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:provider/provider.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Consumer<MyAppState>(builder: (context, state, child) {
        return Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 10,
        children: [
          Container(
            width: 69.2,
            height: 69.2,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(shape: BoxShape.circle),
            child: Image.network(
              state.user.avatar,
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Text('Hey ${state.user.name}!', textAlign: TextAlign.start),
              Text('Lets achieve your goals today.'),
            ],
          ),
        ],
      );
      }),
    );
  }
}
