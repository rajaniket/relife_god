import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:relife_god/constants/assets.dart';
import 'package:relife_god/model/user_habits_model.dart';
import 'package:table_calendar/table_calendar.dart';
import 'dart:collection';

class FullCalendar extends StatefulWidget {
  const FullCalendar({Key? key, required this.userHabitDetail})
      : super(key: key);
  final Details userHabitDetail;

  @override
  State<FullCalendar> createState() => _FullCalendarState();
}

class _FullCalendarState extends State<FullCalendar> {
  final Set<DateTime> _selectedDays = LinkedHashSet<DateTime>(
    equals: isSameDay,
    hashCode: getHashCode,
  );

  //CalendarFormat _calendarFormat = CalendarFormat.twoWeeks;
  DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    for (int i = 0; i < widget.userHabitDetail.streakData!.length; i++) {
      var data = widget.userHabitDetail.streakData![i];

      var year =
          DateTime.fromMillisecondsSinceEpoch(data.createdAt! * 1000).year;
      var month =
          DateTime.fromMillisecondsSinceEpoch(data.createdAt! * 1000).month;
      var day = DateTime.fromMillisecondsSinceEpoch(data.createdAt! * 1000).day;
      // print(data);
      // print(DateTime.fromMicrosecondsSinceEpoch(data.createdAt * 1000));
      // print(
      //     '--------$day---------$month----------$year------${data.createdAt}');
      _selectedDays.add(DateTime(year, month, day));
    }
    super.initState();
  }

  @override
  void dispose() {
    // _selectedEvents.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("calender");
    return TableCalendar<Event>(
      firstDay: DateTime(2000),
      lastDay: DateTime(2050),
      focusedDay: _focusedDay,
      calendarFormat: CalendarFormat.month,
      daysOfWeekHeight: 22,
      rowHeight: 45,
      headerVisible: false,

      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: const TextStyle(
          color: Color(0xFF4F4F4F),
          fontSize: 13,
        ),
        weekendStyle: const TextStyle(
          color: Color(0xFF4F4F4F),
          fontSize: 13,
        ),
        dowTextFormatter: (date, locale) =>
            DateFormat.E(locale).format(date)[0],
      ),

      headerStyle: const HeaderStyle(
          formatButtonVisible: false,
          leftChevronVisible: false,
          rightChevronVisible: false,
          titleCentered: true,
          leftChevronPadding: EdgeInsets.only(left: 50),
          rightChevronPadding: EdgeInsets.only(right: 50),
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w400,
          )),
      startingDayOfWeek: StartingDayOfWeek.sunday,
      calendarStyle: const CalendarStyle(
          outsideDaysVisible: false, isTodayHighlighted: false),
      // selectedDayPredicate: (day) {
      //   // Use values from Set to mark multiple days as selected
      //   return _selectedDays.contains(day);
      // },
      // onDaySelected: _onDaySelected,

      onPageChanged: (focusedDay) {
        _focusedDay = focusedDay;
      },

      calendarBuilders: CalendarBuilders(
        defaultBuilder: (context, date, events) => _selectedDays.contains(date)
            ? Container(
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Color(0xffFA8A3C), Color(0xffFFD037)]),
                  shape: BoxShape.circle,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: Container(
                        height: 30,
                        decoration: const BoxDecoration(
                          color: Color(0xffF7F6F2),
                          shape: BoxShape.circle,
                        ),
                        child: Center(
                          child: Text(
                            date.day.toString(),
                            style: const TextStyle(
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                        right: 3.5,
                        bottom: 3,
                        //  alignment: Alignment.bottomRight,
                        child: SvgPicture.asset(AppAssets.fireIcon)),
                  ],
                ),
              )
            : Container(
                height: 36,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  color: Color(0xffF5DECD),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      color: Color(0xffF7F6F2),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        date.day.toString(),
                        style: const TextStyle(
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                )),
        todayBuilder: (context, date, events) => Container(
            height: 36,
            alignment: Alignment.center,
            decoration: const BoxDecoration(
              color: Color(0xffF5DECD),
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Container(
                height: 30,
                decoration: const BoxDecoration(
                  color: Color(0xffF7F6F2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: const TextStyle(
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            )),
        // outsideBuilder: (context, date, events) => date == DateTime.now()
        //     ? Container(
        //         color: Colors.amber,
        //       )
        //     : Container(),
        // dowBuilder: (context, date) => ,
        // selectedBuilder: (context, date, events) => Container(
        //   height: 36.r,
        //   alignment: Alignment.center,
        //   decoration: const BoxDecoration(
        //     gradient:
        //         LinearGradient(colors: [Color(0xffFA8A3C), Color(0xffFFD037)]),
        //     shape: BoxShape.circle,
        //   ),
        //   child: Stack(
        //     children: [
        //       Center(
        //         child: Container(
        //           height: 30.r,
        //           decoration: const BoxDecoration(
        //             color: Color(0xffF7F6F2),
        //             shape: BoxShape.circle,
        //           ),
        //           child: Center(
        //             child: Text(
        //               date.day.toString(),
        //               style: const TextStyle(
        //                 color: Colors.black,
        //               ),
        //             ),
        //           ),
        //         ),
        //       ),
        //       Positioned(
        //           right: 5.r,
        //           bottom: 3.r,
        //           //  alignment: Alignment.bottomRight,
        //           child: SvgPicture.asset(AppAssets.fireIcon))
        //     ],
        //   ),
        // ),
      ),
    );
  }
}

class Event {
  final String title;

  const Event(this.title);

  @override
  String toString() => title;
}

int getHashCode(DateTime key) {
  return key.day * 1000000 + key.month * 10000 + key.year;
}
