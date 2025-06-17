import 'package:flutter/material.dart';
import 'package:goaly/models/goal_model.dart';
import 'package:goaly/pages/goals/goal_details_page.dart';
import 'package:goaly/providers/goal_provider.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/utils/id_generator.dart';
import 'package:goaly/widgets/checkbox_list_days.dart';
import 'package:provider/provider.dart';

class GoalFormPage extends StatefulWidget {
  final Goal? goal;
  const GoalFormPage({super.key, this.goal});

  @override
  State<GoalFormPage> createState() => _GoalFormPageState();
}

class _GoalFormPageState extends State<GoalFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController newTitle;
  late TextEditingController newDescription;
  late List<int> selectedDays;

  @override
  void initState() {
    super.initState();
    newTitle = TextEditingController(text: widget.goal?.title ?? '');
    newDescription = TextEditingController(
      text: widget.goal?.description ?? '',
    );
    selectedDays = widget.goal?.weekDays.toList() ?? [];
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    newTitle.dispose();
    newDescription.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate() || selectedDays.isEmpty) return;
    try {
      final goalElement = Goal(
        id: widget.goal?.id ?? generateUuid(),
        title: newTitle.text,
        description: newDescription.text,
        weekDays: selectedDays.toList(),
        status: widget.goal?.status ?? 'active',
      );
      if (widget.goal != null) {
        // Update
        Provider.of<GoalProvider>(
          context,
          listen: false,
        ).updateGoal(goalElement);
        _navigateBackWithUpdatedGoal(goalElement);
      } else {
        // Add
        Provider.of<GoalProvider>(context, listen: false).addGoal(goalElement);
        Navigator.of(context).pop();
      }
      _showSuccessMessage();
    } catch (e) {
      _showErrorMessage(e.toString());
    }
  }

  void _navigateBackWithUpdatedGoal(Goal updatedGoal) {
    Navigator.of(context)
      ..pop()
      ..pop()
      ..push(
        MaterialPageRoute(
          builder: (context) => GoalDetailsPage(currentGoal: updatedGoal),
        ),
      );
  }

  void _showSuccessMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(widget.goal != null ? 'Goal Updated!' : 'Goal Created!'),
      ),
    );
  }

  void _showErrorMessage(String error) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('Error: $error')));
  }

  @override
  Widget build(BuildContext context) {
    final isUpdate = widget.goal != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          isUpdate ? 'Update Goal' : 'New Goal',
          style: sectionTitleSty,
        ),
      ),
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
                  onPressed: _submitForm,
                  child: Text(isUpdate ? 'Update' : 'Save'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
