import 'package:buscar_cep/shared/core/analytics/events/event.dart';

class GenericEvent implements Event {
  @override
  Map<String, dynamic>? additionalParams;

  @override
  late Map<String, dynamic> params;

  @override
  late String name;

  GenericEvent({required this.name, Map<String, dynamic>? params}) {
    this.params = params ?? {};
  }
}
