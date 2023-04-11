import 'package:buscar_cep/shared/core/analytics/events/event.dart';
import 'package:buscar_cep/shared/core/analytics/service/analytics_service.dart';
import 'package:firebase_analytics/firebase_analytics.dart';

class FirebaseAnalyticsService implements AnalyticsService {
  static final FirebaseAnalyticsService _instance =
      FirebaseAnalyticsService._();

  final FirebaseAnalytics _analytics = FirebaseAnalytics.instance;

  FirebaseAnalyticsService._();

  factory FirebaseAnalyticsService() => _instance;

  @override
  tag(Event event) {
    _analytics.logEvent(
        name: event.name,
        parameters: event.params..addAll(event.additionalParams ?? {}));
  }
}
