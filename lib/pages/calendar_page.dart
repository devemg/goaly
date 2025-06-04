import 'package:flutter/material.dart';
import 'package:goaly/widgets/goals_list.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.month;
  final List events = [{
    'id': '1234',
    'goalId': '123456',
    'date': DateTime.now(),
    'note': 'Notes 1',
    'status': 'completed',
    'timeLogged': 14654,
  },
  {
    'id': '12345',
    'goalId': '123456',
    'date': DateTime.now(),
    'note': 'Notes 2',
    'status': 'in progress',
    'timeLogged': 14654,
  }];

  _getEventsForDay(day) {
    return events.where((event) {
    final eventDate = event['date'] as DateTime;
    return eventDate.year == day.year &&
           eventDate.month == day.month &&
           eventDate.day == day.day;
  }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TableCalendar(
          firstDay: DateTime.utc(2010, 10, 16),
          lastDay: DateTime.utc(2030, 3, 14),
          focusedDay: _focusedDay,
          calendarFormat: _calendarFormat,
          selectedDayPredicate: (day) {
            // Use `selectedDayPredicate` to determine which day is currently selected.
            // If this returns true, then `day` will be marked as selected.
            return isSameDay(_selectedDay, day);
          },
          onDaySelected: (selectedDay, focusedDay) {
            if (!isSameDay(_selectedDay, selectedDay)) {
              setState(() {
                _selectedDay = selectedDay;
                _focusedDay = focusedDay;
              });
            }
          },
          onFormatChanged: (format) {
            setState(() {
              _calendarFormat = format;
            });
          },
          eventLoader: (day) {
            return _getEventsForDay(day);
          },
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
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
                children: [Text("Today's Goals"), Text('Dec 13')],
              ),
            ],
          ),
        ),
        GoalsList(showActions: false),
      ],
    );
  }
}
