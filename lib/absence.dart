// ignore_for_file: avoid_print

import 'dart:core';

import 'package:flutter/material.dart';

import 'package:myapp/historique.dart';
import 'package:myapp/homee.dart';
import 'package:myapp/utils.dart';
import 'package:myapp/formulaire.dart';
import 'package:table_calendar/table_calendar.dart';

class Absencee extends StatefulWidget {
  const Absencee({super.key});

  @override
  State<Absencee> createState() => _AbsenceeState();
}

class _AbsenceeState extends State<Absencee> {
  int _currentIndex = 1;

  CalendarFormat _calendarFormat = CalendarFormat.month;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  int rangeCount = 0;

  @override
  void initState() {
    super.initState();
    _selectedDay = _focusedDay;
  }

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    setState(() {
      if (_selectedDay != null &&
          !isSameDay(_selectedDay!, selectedDay) &&
          _rangeStart == null) {
        // Clear existing selection and set a new single-day selection
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      } else if (_rangeStart != null) {
        // Reset to a single-day selection if a range is already selected
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null;
        _rangeEnd = null;
      } else {
        // Set a new single-day selection
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
      }
    });
  }

  void _navigateToFormulaire() {
    if ((_selectedDay != null) || (_rangeStart != null && _rangeEnd != null)) {
      rangeCount = calculateRangeCount();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Formulaire(
            startDate: _selectedDay ?? _rangeStart,
            endDate: _selectedDay ?? _rangeEnd,
            count: rangeCount,
          ),
        ),
      );
    }
  }

  int calculateRangeCount() {
    if (_rangeStart != null && _rangeEnd != null) {
      DateTime currentDate = _rangeStart!;
      int count = 0;

      while (currentDate.isBefore(_rangeEnd!) ||
          currentDate.isAtSameMomentAs(_rangeEnd!)) {
        // Exclude Saturdays and Sundays (assuming Monday is the start of the week)
        if (currentDate.weekday != DateTime.saturday &&
            currentDate.weekday != DateTime.sunday) {
          count++;
        }

        currentDate = currentDate.add(const Duration(days: 1));
      }

      print('Selected Range Count (excluding weekends): $count');
      return count;
    } else {
      // Single day selected
      return 1;
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeEnd = end;
      _rangeStart = start;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              backgroundColor: const Color.fromARGB(255, 244, 240, 240),
              selectedItemColor: const Color.fromRGBO(8, 65, 142, 1),
              unselectedItemColor: Colors.grey[500],
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.home_outlined, size: 30),
                  label: 'Accueil',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.add_circle,
                    size: 40,
                    color: Color.fromRGBO(8, 65, 142, 1),
                  ),
                  label: 'Congés',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.history,
                    size: 30,
                  ),
                  label: 'Historique',
                ),
              ],
              onTap: (index) {
                // Handle navigation based on the selected index
                setState(() {
                  _currentIndex = index;
                });

                if (index == 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Homee()),
                  );
                } else if (index == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Absencee()),
                  );
                } else if (index == 2) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Historique()),
                  );
                }
              },
            ),
            appBar: AppBar(
              elevation: 6,
              shadowColor: Colors.grey,
              automaticallyImplyLeading: false,
              backgroundColor: const Color.fromRGBO(8, 65, 142, 1),
              centerTitle: true,
              title: Text(
                "Demande d'absence",
                textAlign: TextAlign.center,
                style: SafeGoogleFont(
                  'Lato',
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: const Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),
            body: Column(children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 255, 255),
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: Colors.transparent)),
                  child: TabBar(
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicatorColor: Colors.white,
                      indicator: BoxDecoration(
                        color: const Color.fromARGB(255, 244, 247, 248),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      labelColor: const Color.fromRGBO(8, 65, 142, 1),
                      indicatorWeight: 2,
                      labelStyle: const TextStyle(
                        fontFamily: 'Lato',
                        fontWeight: FontWeight.w500,
                        fontSize: 15,
                      ),
                      tabs: const [
                        Tab(text: 'Mon Calendrier'),
                        Tab(text: ' Mes Collègues'),
                      ]),
                ),
              ),
              Container(
                height: MediaQuery.of(context).size.height - 250,
                margin: const EdgeInsets.only(top: 30),
                child: TabBarView(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(left: 10, right: 10),
                            child: TableCalendar(
                              headerStyle: const HeaderStyle(
                                  titleCentered: true,
                                  titleTextStyle: TextStyle(
                                    fontFamily: 'Lato',
                                    fontWeight: FontWeight.w400,
                                    fontSize: 22.0,
                                  ),
                                  formatButtonVisible: false,
                                  headerPadding: EdgeInsets.all(8.0)),
                              focusedDay: _focusedDay,
                              firstDay: DateTime.utc(2023, 10, 16),
                              lastDay: DateTime.utc(2030, 10, 16),
                              calendarFormat: _calendarFormat,
                              startingDayOfWeek: StartingDayOfWeek.monday,
                              onDaySelected: (selectedDay, focusedDay) {
                                _onDaySelected(selectedDay, focusedDay);
                              },
                              onDayLongPressed: (selectedDay, focusedDay) {
                                setState(() {
                                  _selectedDay = selectedDay;
                                });
                              },
                              rangeStartDay: _rangeStart,
                              rangeEndDay: _rangeEnd,
                              onRangeSelected: _onRangeSelected,
                              rangeSelectionMode: RangeSelectionMode.toggledOn,
                              calendarStyle: const CalendarStyle(
                                outsideDaysVisible: false,
                                selectedDecoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color:
                                      Colors.red, // Change this color as needed
                                ),
                              ),
                              calendarBuilders: CalendarBuilders(
                                defaultBuilder: (context, date, events) {
                                  final dayOfWeek = date.weekday;

                                  // Check if it's Sunday or Saturday
                                  if (dayOfWeek == DateTime.sunday ||
                                      dayOfWeek == DateTime.saturday) {
                                    return Container(
                                      margin: const EdgeInsets.all(4),
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            Color.fromARGB(255, 187, 186, 186),
                                      ),
                                      child: Center(
                                        child: Text(
                                          '${date.day}',
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    );
                                  } else {
                                    return null;
                                  }
                                },
                              ),
                              enabledDayPredicate: (DateTime day) {
                                // Make Sundays and Saturdays unselectable
                                return day.weekday != DateTime.sunday &&
                                    day.weekday != DateTime.saturday;
                              },
                              onFormatChanged: (format) {
                                if (_calendarFormat != format) {
                                  setState(() {
                                    _calendarFormat = format;
                                  });
                                }
                              },
                              onPageChanged: (focusedDay) {
                                _focusedDay = focusedDay;
                              },
                            ),
                          ),
                          const SizedBox(height: 40),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: SizedBox(
                              width: 380,
                              child: TextButton(
                                  onPressed: () {
                                    _navigateToFormulaire();
                                  },
                                  style: TextButton.styleFrom(
                                      backgroundColor:
                                          const Color.fromRGBO(8, 65, 142, 1),
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 12.0, horizontal: 12.0),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10.0))),
                                  child: const Text(
                                    "Valider",
                                    style: TextStyle(
                                      fontFamily: 'Lato',
                                      color: Colors.white,
                                      letterSpacing: 0.5,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const Text("aa"),
                  ],
                ),
              ),
            ])));
  }
}