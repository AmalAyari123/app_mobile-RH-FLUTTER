import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:myapp/Controller/autorisationController.dart';
import 'package:myapp/Controller/demandeController.dart';
import 'package:myapp/Controller/providerUser.dart';
import 'package:myapp/Controller/userController.dart';
import 'package:myapp/Model/autorisation.dart';
import 'package:myapp/Model/demande.dart';
import 'package:myapp/Model/departement.dart';
import 'package:myapp/Model/user.dart';
import 'package:myapp/admin/autorisation.dart';
import 'package:myapp/admin/demande.dart';
import 'package:myapp/utils.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:calendar_view/calendar_view.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    ProviderUser providerUser = context.watch<ProviderUser>();
    List<User>? users = providerUser.employes;

    getUsersController(providerUser);
    List<Demande>? demandes = providerUser.demandes;
    getDemandeController(providerUser);
    DemandDataSource _dataSource = DemandDataSource(demandes, users);
    ProviderDepartement providerDepartement =
        context.watch<ProviderDepartement>();
    getDepartementsController(providerDepartement);
    List<Autorisation>? autorisations = providerUser.autorisations;

    getAutorisationController(providerUser);
    List<Departement>? departements = providerDepartement.departements;
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        /*  appBar: AppBar(
            leading: const BackButton(),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),*/
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 255, 255),
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(color: Colors.transparent)),
                child: TabBar(
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorColor: Colors.white,
                  indicator: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 250, 250),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  labelColor: const Color.fromRGBO(8, 65, 142, 1),
                  indicatorWeight: 2,
                  labelStyle: const TextStyle(
                    fontFamily: 'Lato',
                    fontWeight: FontWeight.w400,
                    fontSize: 16,
                  ),
                  tabs: const [
                    Tab(text: 'Les Congés'),
                    Tab(text: ' Les autorisations'),
                  ],
                  onTap: (index) {
                    setState(() {
                      _selectedIndex = index;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height - 135,
              width: MediaQuery.of(context).size.height,
              child: TabBarView(children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 40),
                  child: SfCalendar(
                    view: CalendarView.month,
                    firstDayOfWeek: 1,
                    allowViewNavigation: false,
                    cellBorderColor: Colors.transparent,
                    monthViewSettings: const MonthViewSettings(
                      numberOfWeeksInView: 3,
                      appointmentDisplayMode:
                          MonthAppointmentDisplayMode.appointment,
                    ),
                    dataSource: _dataSource,
                    headerHeight: 60,
                    headerStyle: const CalendarHeaderStyle(
                        textStyle: TextStyle(fontSize: 23, fontFamily: 'Lato'),
                        backgroundColor: Colors.white),
                    appointmentBuilder: (BuildContext context,
                        CalendarAppointmentDetails details) {
                      String notes = details.appointments.first.notes;

                      return Container(
                        color: details.appointments.first.color,
                        child: Center(
                          child: Text(notes,
                              style: const TextStyle(
                                  color: Color.fromARGB(255, 245, 242, 242),
                                  fontSize: 13)),
                        ),
                      );
                    },
                  ),
                ),
                WeekView(
                    controller: EventController(),
                    eventTileBuilder: (date, events, boundry, start, end) {
                      // Return your widget to display as event tile.
                      return Container();
                    },
                    fullDayEventBuilder: (events, date) {
                      // Return your widget to display full day event view.
                      return Container();
                    },
                    showLiveTimeLineInAllDays:
                        true, // To display live time line in all pages in week view.
                    width: MediaQuery.of(context).size.height / 1.9,
// width of week view.
                    minDay: DateTime(2023),
                    maxDay: DateTime(2050),
                    initialDay: DateTime(2024),
                    heightPerMinute:
                        1, // height occupied by 1 minute time span.
                    eventArranger:
                        const SideEventArranger(), // To define how simultaneous events will be arranged.
                    onEventTap: (events, date) => print(events),
                    onDateLongPress: (date) => print(date),
                    // To change the first day of the week.
                    startHour: 8,

                    // To set the first hour displayed (ex: 05:00)
                    showVerticalLines:
                        false, // Show the vertical line between days.

                    weekPageHeaderBuilder:
                        WeekHeader.hidden // To hide week header
                    ),
              ]),
            ),
            Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 9.0),
                  child: Row(
                    children: [
                      Container(
                        width: 10, // Adjust width according to your requirement
                        height:
                            10, // Adjust height according to your requirement
                        decoration: const BoxDecoration(
                          color: const Color.fromARGB(187, 88, 242, 93),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                          width: 3), // Adjust the space between circle and text
                      const Text(
                        "Accepté",
                        style: TextStyle(
                          fontSize:
                              16, // Adjust font size according to your requirement
                          // Add more style properties if needed
                        ),
                      ),
                      const SizedBox(width: 18),

                      Container(
                        width: 10, // Adjust width according to your requirement
                        height:
                            10, // Adjust height according to your requirement
                        decoration: const BoxDecoration(
                          color: const Color.fromARGB(255, 21, 107, 178),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(
                          width: 3), // Adjust the space between circle and text
                      const Text(
                        "En Attente",
                        style: TextStyle(
                          fontSize:
                              16, // Adjust font size according to your requirement
                          // Add more style properties if needed
                        ),
                      ),
                      const SizedBox(width: 18),
                      GestureDetector(
                        onTap: () {
                          // When the icon is clicked, show a bottom sheet with department list
                          showModalBottomSheet(
                            context: context,
                            builder: (BuildContext context) {
                              return Container(
                                height: MediaQuery.of(context).size.height / 2,
                                child: ListView.builder(
                                  itemCount: departements!.length,
                                  itemBuilder: (context, index) {
                                    return ListTile(
                                      title:
                                          Text(departements[index].name ?? ''),
                                      trailing: Checkbox(
                                        checkColor: Colors.blue,
                                        // Define checkbox logic here
                                        value:
                                            false, // Example: Use false for unchecked state
                                        onChanged: (bool? newvalue) {},
                                      ),
                                      onTap: () {
                                        // Handle selection here if needed
                                        Navigator.pop(
                                            context); // Close bottom sheet
                                      },
                                    );
                                  },
                                ),
                              );
                            },
                          );
                        },
                        child: FaIcon(
                          FontAwesomeIcons.sliders,
                          size: 20,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 7,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.1,
                  height: 40,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                      backgroundColor: const Color(0xff2da9ef),
                    ),
                    onPressed: () async {
                      if (_selectedIndex == 0) {
                        // Navigate to Demands() page
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return const Demands();
                          }),
                        );
                      } else {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) {
                            return const Autorisations();
                          }),
                        );
                      }
                    },
                    child: Text(
                      _selectedIndex == 0
                          ? 'Gérer les demandes'
                          : 'Gérer les autorisations',
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class DemandDataSource extends CalendarDataSource {
  @override
  final List<Appointment> appointments;

  DemandDataSource(List<Demande>? demandes, List<User>? users)
      : appointments = [] {
    if (demandes != null && users != null) {
      for (var demande in demandes) {
        // Check if the demande's user ID is not the same as the current user's ID

        User? user = users.firstWhere(
          (user) => user.id == demande.userId,
          orElse: () => User(id: -1, name: 'Unknown'),
        );
        Color appointmentColor = _getAppointmentColor(demande.status);

        Appointment appointment = Appointment(
          color: appointmentColor,
          startTime: demande.dateDebut!,
          endTime: demande.dateFin!,
          notes: user!.name ?? 'Unknown',
        );

        appointments.add(appointment);
      }
    }
  }
}

Color _getAppointmentColor(String? status) {
  switch (status) {
    case 'Accepté':
      return const Color.fromARGB(
          184, 57, 165, 61); // Green color for accepted demands
    case 'Accepté par le chef département':
      return const Color.fromARGB(
          184, 57, 165, 61); // Red color for rejected demands
    case 'En Attente':
      return const Color.fromARGB(
          255, 21, 107, 178); // Yellow color for pending demands
    default:
      return Colors.grey; // Default color for other cases
  }
}
