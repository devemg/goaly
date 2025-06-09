import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/widgets/checkbox_list_days.dart';
import 'package:provider/provider.dart';

class NewGoalPage extends StatefulWidget {
  @override
  State<NewGoalPage> createState() => _NewGoalPageState();
}

class _NewGoalPageState extends State<NewGoalPage> {
  List<int> selectedDays = [];

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
      appBar: AppBar(title: Text('New Goal', style: sectionTitleSty) ),
      body: ListView(
        padding: EdgeInsetsGeometry.symmetric(vertical: 20, horizontal: 25),
        children: [
          Form(
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
                      child: Text(
                        style: linkSty,
                        selectedDays.length == 7
                            ? 'Unselect All'
                            : 'Select All',
                      ),
                      onTap: () {
                        // select/unselect days
                        setState(() {
                          if (selectedDays.length == 7) {
                            selectedDays = [];
                          } else {
                            selectedDays = [1, 2, 3, 4, 5, 6, 7];
                          }
                        });
                      },
                    ),
                  ],
                ),
                DaysCheckboxList(
                  selectedDays: selectedDays,
                  onChanged: (key, value) {
                    setState(() {
                      if (value) {
                        selectedDays.add(key);
                      } else {
                        selectedDays.remove(key);
                      }
                    });
                  },
                ),
                SizedBox(height: 25),
                FilledButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate() &&
                        selectedDays.isNotEmpty) {
                      var state = context.read<MyAppState>();
                      state.add(
                        title: newTitle.text,
                        description: newDescription.text,
                        weekDays: selectedDays.map((day) => day).toList(),
                      );
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
        ],
      ),
    );
  }
}
