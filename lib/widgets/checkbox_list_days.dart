import 'package:flutter/material.dart';
import 'package:goaly/models/day_checkbox.dart';

class DaysCheckboxList extends StatelessWidget {
  final List<DayCheckbox> days;
  final ValueChanged<DayCheckbox> onChanged;

  const DaysCheckboxList({
    super.key,
    required this.days,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: List.generate(
        days.length,
        (index) => CheckboxListTile(
          value: days[index].isChecked,
          onChanged: (value) {
            onChanged(days[index].copyWith(isChecked: value));
          },
          title: Text(days[index].name),
        ),
      ),
    );
  }
}
