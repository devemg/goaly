import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:goaly/models/day_checkbox.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/utils/id_generator.dart';
import 'package:goaly/widgets/checkbox_list_days.dart';
import 'package:provider/provider.dart';

class NewGoalPage extends StatefulWidget {
  @override
  State<NewGoalPage> createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {
  final List<DayCheckbox> days = [
    DayCheckbox(name: 'Monday', isChecked: false, index: 0),
    DayCheckbox(name: 'Tuesday', isChecked: false, index: 1),
    DayCheckbox(name: 'Wednesday', isChecked: false, index: 2),
    DayCheckbox(name: 'Thursday', isChecked: false, index: 3),
    DayCheckbox(name: 'Friday', isChecked: false, index: 4),
    DayCheckbox(name: 'Saturday', isChecked: false, index: 5),
    DayCheckbox(name: 'Sunday', isChecked: false, index: 6),
  ];

  final _formKey = GlobalKey<FormState>();
  final newTitle = TextEditingController();
  final newDescription = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newTitle.dispose();
    newDescription.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Text('New Goal'),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                spacing: 10,
                children: [
                  TextFormField(
                    controller: newTitle,
                    decoration: InputDecoration(labelText: 'Goal Title'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The title is required.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: newDescription,
                    decoration: InputDecoration(labelText: 'Goal Description'),
                    minLines: 3,
                    maxLines: 3,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'The description is required.';
                      }
                      return null;
                    },
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Text('Select the week days for the goal'),
                      GestureDetector(
                        child: const Text('Select All'),
                        onTap: () {
                          setState(() {
                            for (var day in days) {
                              day.isChecked =
                                  true; // Esto solo funciona si DayCheckbox es mutable (tiene un setter para isChecked)
                            }
                          });
                        },
                      ),
                    ],
                  ),
                  DaysCheckboxList(
                    days: days,
                    onChanged: (value) {
                      setState(() {
                        days[value.index] = value;
                      });
                    },
                  ),
                  FilledButton(
                    onPressed: () {
                      var selectedDays = days.where((d) => d.isChecked);
                      if (_formKey.currentState!.validate() &&
                          selectedDays.isNotEmpty) {
                        var newGoal = Goal(
                          id: generateUuid(),
                          title: newTitle.text,
                          description: newDescription.text,
                          status: 'active',
                          weekDays: selectedDays
                              .map((day) => day.index)
                              .toList(),
                        );
                        print(newGoal);
                        var cart = context.read<MyAppState>();
                        cart.add(newGoal);
                        Navigator.pop(context);
                        // you'd often call a server or save the information in a database.
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Goal Created!')),
                        );
                        //
                      }
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
