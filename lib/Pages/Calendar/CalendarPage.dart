import 'package:flutter/material.dart';
import 'package:kalendar/kalendar.dart';
// import 'package:flutter_calendar/calendar_tile.dart';
// import 'package:flutter_calendar/flutter_calendar.dart';
import 'package:persno_manage/widgets/myScaffold.dart';
// import 'package:table_calendar/table_calendar.dart';
// import 'package:simple_gesture_detector/simple_gesture_detector.dart';

class CalendarPage extends StatefulWidget {
  static final String routeName = "/Calendar";
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  // CalendarController _calendarController = CalendarController();
  @override
  void initState() {
    // _calendarController.setCalendarFormat(CalendarFormat.month);
    // _calendarController.setFocusedDay(DateTime.now().add(Duration(days: 1)));
    // _calendarController.setSelectedDay(DateTime.now().add(Duration(days: 1)));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    
    return MyScaffold(
      body: Container(
        padding: const EdgeInsets.all(10),
        width: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Container(height: 00),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Text("Hey Mike", style: Theme.of(context).textTheme.display1),
                  Text("These are your calendar events", style: Theme.of(context).textTheme.subhead),                  
                ],
              ),
            ),
            Padding(padding: const EdgeInsets.all(5),),
            // TableCalendar(calendarController: _calendarController,)
            // Calendar(
            //   showChevronsToChangeRange: false,
            //   isExpandable: true,
            //   showTodayAction: true,
            // ),
            Expanded(
              child: Kalendar(
                borderRadius: 50,
                markedDates: {"":[DateTime.now().toLocal().add(Duration(days: 2)).toString()]},
                dayTileBuilder: (props) {
                  return Center(
                    child: Text(props.dateTime.day.toString()),
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {}
      )
    );
  }

  @override
  void dispose() {
    // _calendarController.dispose();
    super.dispose();
  }

}