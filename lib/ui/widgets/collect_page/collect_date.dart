import 'package:catatudo_app/core/viewModel/add_collect_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CollectDate extends StatefulWidget {
  @override
  _CollectDateState createState() => _CollectDateState();
}

class _CollectDateState extends State<CollectDate> {
  CalendarController _calendarController = CalendarController();

  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AddCollectModel>(
      builder: (context, model, child) => SingleChildScrollView(
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height * 0.70,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.fromLTRB(5, 10, 5, 10),
                  alignment: Alignment.center,
                  height: 100,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                        width: 1.0, color: Theme.of(context).primaryColor),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Column(
                    children: <Widget>[
                      Text(
                        'ESCOLHA AQUI UMA DATA',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'importante lembrar que você deve escolher um dia (de segunda à sábado) que alguém esteja no local',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.grey,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: Container(
                    width: 290,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                            width: 1.0, color: Theme.of(context).primaryColor),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            offset: Offset(0.0, 2.0),
                            blurRadius: 6.0,
                          ),
                        ],
                      ),
                      child: TableCalendar(
                        locale: 'pt_BR',
                        onDaySelected: (date, actions) {
                          model.setDateCollect(date);
                        },
                        calendarController: _calendarController,
                        daysOfWeekStyle: DaysOfWeekStyle(
                          weekdayStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          weekendStyle: TextStyle(
                            color: Colors.green[900],
                          ),
                        ),
                        calendarStyle: CalendarStyle(
                          todayColor: Colors.grey,
                          selectedColor: Theme.of(context).primaryColor,
                          contentPadding: EdgeInsets.fromLTRB(10, 5, 10, 0),
                          weekendStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                          outsideWeekendStyle:
                              TextStyle(color: Theme.of(context).primaryColor),
                        ),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonVisible: false,
                          headerMargin: EdgeInsets.fromLTRB(5, 5, 5, 0),
                          titleTextStyle: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                          ),
                          leftChevronIcon: Icon(
                              FontAwesomeIcons.arrowAltCircleLeft,
                              color: Colors.white),
                          rightChevronIcon: Icon(
                              FontAwesomeIcons.arrowAltCircleRight,
                              color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
