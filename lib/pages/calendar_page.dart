import 'package:flutter/material.dart';
import 'package:goaly/main.dart';
import 'package:goaly/pages/new_goal_page.dart';
import 'package:goaly/styles/sizes.dart';
import 'package:goaly/widgets/goals_list.dart';
import 'package:goaly/widgets/goals_log_list.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  CalendarFormat _calendarFormat = CalendarFormat.week;
  

  @override
  Widget build(BuildContext context) {
    var isToday =
        _focusedDay.year == DateTime.now().year &&
        _focusedDay.month == DateTime.now().month &&
        _focusedDay.day == DateTime.now().day;
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Consumer<MyAppState>(builder: (context,state, child) {
      
            return TableCalendar(
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
              return state.goals.where((event) {
                return event.weekDays?.contains(day.weekday) ?? false;
              }).toList();
            },
          );
          }),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
                spacing: 10,
                children: [
                  Row(
                    children: [
                      FilledButton.icon(
                        label: Text('Add Goal'),
                        icon: Icon(Icons.add),
                        onPressed: () {
                          Navigator.push(context, MaterialPageRoute(builder: (context) => NewGoalPage()));
                        },
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
                    children: [
                      Text("${isToday ? "Today's" : ''} Goals", style: sectionSubtitleSty),
                      Text(DateFormat('MMMM d').format(_focusedDay), style: sectionSubtitleSty),
                    ],
                  ),
                ],
              ),
          ),
          if (isToday) GoalsList() else GoalsLogList(),
        ],
      ),
    );
  }
}
