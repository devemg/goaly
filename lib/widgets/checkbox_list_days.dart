import 'package:flutter/material.dart';
import 'package:goaly/models/day_checkbox.dart';


class DaysCheckboxList extends StatelessWidget {
  final void Function(int, bool) onChanged;
  final List<int> selectedDays;
  final List<DayCheckbox> days = [
    DayCheckbox(name: 'Monday',key: 1),
    DayCheckbox(name: 'Tuesday', key: 2),
    DayCheckbox(name: 'Wednesday', key: 3),
    DayCheckbox(name: 'Thursday', key: 4),
    DayCheckbox(name: 'Friday', key: 5),
    DayCheckbox(name: 'Saturday', key: 6),
    DayCheckbox(name: 'Sunday', key: 7),
  ];

  DaysCheckboxList({
    super.key,
    required this.selectedDays,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      runSpacing: 10,
      children: List.generate(
        days.length,
        (index) => FilterChip(
          label: Text(days[index].name),
          selected: selectedDays.contains(days[index].key),
          onSelected: (key) {
            onChanged(days[index].key, key);
          },
        ),
      ),
    );
  }
}
