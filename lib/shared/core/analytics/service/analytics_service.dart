import 'package:flutter/widgets.dart';
import '../events/event.dart';

class AnalyticsDriver {
  static final AnalyticsDriver _instance = AnalyticsDriver._();

  AnalyticsDriver._();

  init(List<AnalyticsService> services) {
    this.services = services;
  }

  late final List<AnalyticsService> services;

  factory AnalyticsDriver() => _instance;

  tag(Event event) {
    debugPrint("EVENT: ${event.name}");
    for (var element in services) {
      element.tag(event);
    }
  }
}

abstract class AnalyticsService {
  void tag(Event event);
}
