import 'package:flutter/material.dart';

class EventsProvider extends ChangeNotifier{
  DateTime? day;
  Map<DateTime, List> events = {};

  getEvents() {
    return events;
  }
  
  setEvents(day,contents,iconIndex) {
    Map<int, String> eventsContents = { iconIndex: '$contents' };
    if(events.containsKey(day)) {
      if(events[day]!.length < 3) {
        events[day]!.add(eventsContents);
      } else {
        return '초과';
      }
    } else {
      List evnets_list = [];
      Map<DateTime, List> selected_events = { day: evnets_list};
      evnets_list.add(eventsContents);
      events.addAll(selected_events);
    }
    notifyListeners();
  }

  deleteEvents(seletedDay,index) {
    List evenstList = events[seletedDay]!;
    evenstList.removeAt(index);
  }
}