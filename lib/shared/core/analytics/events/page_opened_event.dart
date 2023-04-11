import 'package:buscar_cep/shared/core/analytics/events/event.dart';

class PageOpenedEvent implements Event {
  @override
  Map<String, dynamic>? additionalParams;

  @override
  late String name;

  @override
  late Map<String, dynamic> params;

  PageOpenedEvent(String name) {
    this.name = "${name}PageOpened";
    params = {};
  }
}
