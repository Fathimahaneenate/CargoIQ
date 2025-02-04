
import 'package:courier/COMMONVIEWMODEL/commonviewmodel.dart';
import 'package:courier/MODEL/calendermodel.dart';
import 'package:courier/Screen/schedule2.dart';
import 'package:courier/Screen/summery.dart';
import 'package:courier/VIEWMODEL/calenderviewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';

import '../Provider/sammeryprovider.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key,});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  DateTime today = DateTime.now();

  @override
  void initState() {
    super.initState();
     Future.microtask(() =>
        Provider.of<CommonViewModel>(context, listen: false).getdates());
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    final viewModel = Provider.of<CommonViewModel>(context, listen: false);

    final calendarDate = viewModel.calenderlist.firstWhere(
      (item) => isSameDay(item.date, selectedDay),
      orElse: () => CalendarViewModel(data: Calendermodel()),
    );

    if (calendarDate != null && calendarDate.isAvailable) {
      
      context.read<SummaryProvider>().setScheduleDate(selectedDay);
      Navigator.pop(context, selectedDay);
      setState(() {
        today = selectedDay; // Update selected day if available
      });
    } else {
      // If date is not available, show a Snackbar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("This date is not available."),
          duration: Duration(seconds: 2),
        ),
      );
    }

    setState(() {
      today = selectedDay;
    });

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SummaryPage()
        // SchedulePage2(selectedDate: selectedDay),
      ),
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   final viewModel = Provider.of<CommonViewModel>(context);

  //   return Scaffold(
  //     backgroundColor: Colors.white,
  //     appBar: AppBar(
  //       surfaceTintColor: Colors.white,
  //       backgroundColor: Colors.white,
  //       elevation: 0,
  //       // title: const Text("Schedule Page"),
  //     ),
  //     body: Column(
  //       children: [
  //         Padding(
  //           padding: const EdgeInsets.all(8.0),
  //           child: Text("Choose Your Pickup Date",
  //           style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
  //         ),
  //         SizedBox(
  //           height: 10,
  //         ),
  //         if (viewModel.calenderload)
  //           Center(
  //             child: CircularProgressIndicator(),
  //           )
  //         else if (viewModel.calenderlist.isEmpty)
  //           Center(
  //             child: Text("No dates available"),
  //           )
  //         else
  //         Padding(
  //           padding: const EdgeInsets.only(left: 16,right: 16, top: 50),
  //           child: Container(
  //             height: MediaQuery.of(context).size.height / 2,
  //             width: MediaQuery.of(context).size.width,
  //             decoration: BoxDecoration(
  //               color: Colors.white,
  //               borderRadius: BorderRadius.circular(12),
  //               boxShadow: [
  //                 BoxShadow(
  //                   color: Colors.grey,
  //                   blurRadius: 10,
  //                   offset: Offset(0, 5)
  //                 )
  //               ]
  //             ),
  //             child: TableCalendar(
  //                 rowHeight: 43,
  //                 headerStyle: const HeaderStyle(
  //                   formatButtonVisible: false,
  //                   titleCentered: true,
  //                 ),
  //                 availableGestures: AvailableGestures.all,
  //                 selectedDayPredicate: (day) => isSameDay(day, today),
  //                 focusedDay: today,
  //                 firstDay: DateTime.utc(2024, 12, 1),
  //                 lastDay: DateTime.utc(2026, 12, 31),
  //                 onDaySelected: _onDaySelected,
  //                 calendarStyle:  CalendarStyle(
  //                    todayDecoration: BoxDecoration(),
  //                   todayTextStyle: TextStyle(
  //                     color: Color(0xfff071e30),
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   selectedDecoration: BoxDecoration(
  //                     color: Color(0xfff071e30),
  //                     shape: BoxShape.circle,
  //                   ),
  //                   selectedTextStyle: TextStyle(
  //                     color: Colors.white,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                   weekendTextStyle: TextStyle(color: Colors.redAccent)
  //                 ),
  //                   calendarBuilders: CalendarBuilders(
  //                   defaultBuilder: (context, day, focusedDay) {
  //                     // Find the calendar entry for the current day
  //                     final calendarDate = viewModel.calenderlist
  //                         .firstWhere(
  //                           (item) => isSameDay(item.date, day),
  //                           orElse: () => CalendarViewModel(data: Calendermodel()),
  //                         );

  //                     if (calendarDate != null) {
  //                       // Check availability and return the correct styling
  //                       return Container(
  //                         decoration: BoxDecoration(
  //                           color: calendarDate.isAvailable
  //                               ? Colors.green.shade500 // Available dates in green
  //                               : Colors.white, // Unavailable dates in white
  //                           shape: BoxShape.circle,
  //                         ),
  //                         alignment: Alignment.center,
  //                         child: Text(
  //                           '${day.day}',
  //                           style: TextStyle(
  //                             color: calendarDate.isAvailable
  //                                 ? Colors.black // Black text for available days
  //                                 : Colors.grey, // Grey text for unavailable days
  //                             fontWeight: FontWeight.bold,
  //                           ),
  //                         ),
  //                       );
  //                     }

  //                     // If no entry in the list for this day, return the default style
  //                     return Container(
  //                       decoration: BoxDecoration(
  //                         shape: BoxShape.circle,
  //                       ),
  //                       alignment: Alignment.center,
  //                       child: Text(
  //                         '${day.day}',
  //                         style: TextStyle(
  //                           color: Colors.black,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     );
  //                   },
  //                 ),
  //               ),
  //           ),
  //         ),
          
  //       ],
  //     ),
  //   );
  // }


    @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<CommonViewModel>(context);
    
    // Assuming the order date is stored in the ViewModel, otherwise fetch it accordingly
    DateTime orderDate = viewModel.orderDate; // Get the order date
    DateTime startDate = orderDate;
    DateTime endDate = orderDate.add(Duration(days: 3)); // Only allow selection within 3 days of the order date

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        surfaceTintColor: Colors.white,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Choose Your Pickup Date",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ),
          SizedBox(height: 10),
          if (viewModel.calenderload)
            Center(child: CircularProgressIndicator())
          else if (viewModel.calenderlist.isEmpty)
            Center(child: Text("No dates available"))
          else
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16, top: 50),
              child: Container(
                height: MediaQuery.of(context).size.height / 2,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey,
                      blurRadius: 10,
                      offset: Offset(0, 5),
                    )
                  ],
                ),
                child: TableCalendar(
                  rowHeight: 43,
                  headerStyle: const HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                  ),
                  availableGestures: AvailableGestures.all,
                  selectedDayPredicate: (day) => isSameDay(day, today),
                  focusedDay: today,
                  firstDay: DateTime.utc(2024, 1, 1),
                  lastDay: DateTime.utc(2026, 12, 31),
                  onDaySelected: (selectedDay, focusedDay) {
                    if (selectedDay.isAfter(endDate) ||
                        selectedDay.isBefore(startDate)) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text("You can only select from ${startDate.toLocal()} to ${endDate.toLocal()}"),
                          duration: Duration(seconds: 2),
                        ),
                      );
                      return;
                    }

                    _onDaySelected(selectedDay, focusedDay);
                  },
                  calendarStyle: CalendarStyle(
                    todayDecoration: BoxDecoration(),
                    todayTextStyle: TextStyle(
                      color: Color(0xfff071e30),
                      fontWeight: FontWeight.bold,
                    ),
                    selectedDecoration: BoxDecoration(
                      color: Color(0xfff071e30),
                      shape: BoxShape.circle,
                    ),
                    selectedTextStyle: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                    weekendTextStyle: TextStyle(color: Colors.redAccent),
                  ),
                  calendarBuilders: CalendarBuilders(
                    defaultBuilder: (context, day, focusedDay) {
                      bool isWithinRange =
                          day.isAfter(startDate.subtract(Duration(days: 1))) &&
                          day.isBefore(endDate.add(Duration(days: 1)));

                      return Container(
                        decoration: BoxDecoration(
                          color: isWithinRange
                              ? Colors.green.shade500 // Available dates in green
                              : Colors.grey.shade300, // Unavailable dates in grey
                          shape: BoxShape.circle,
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                            color: isWithinRange
                                ? Colors.black // Black text for available days
                                : Colors.grey, // Grey text for unavailable days
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

}
