import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class EventsProvider extends ChangeNotifier{
  DateTime? day;
  Map<String, dynamic> events = {};

  loadEvents(Map<String,dynamic> a) {
    events.addAll(a);
  }

  removeEvents() {
    events.clear();
  }

  getEvents() {
    return events;
  }

  setEvents(day,contents,iconIndex) {
    String dayData= DateFormat('yy/MM/dd').format(day);
    Map<String, dynamic> eventsContents = { "iconIndex": iconIndex, "contents": '$contents' };
    if(events.containsKey(dayData)) {
      if(events[dayData]!.length < 3) {
        events[dayData]!.add(eventsContents);
      } else {
        return '초과';
      }
    } else {
      List eventsList = [];
      Map<String, dynamic> selectedEvents = { dayData: eventsList };
      eventsList.add(eventsContents);
      events.addAll(selectedEvents);
    }
    notifyListeners();
  }

  deleteEvents(selectedDay,index) {
    String dayData= DateFormat('yy/MM/dd').format(selectedDay);
    List eventsList = events[dayData]!;
    eventsList.removeAt(index);
  }
}