abstract class Event {
  String name;
  Map<String, dynamic>? additionalParams;
  Map<String, dynamic> params;

  Event({
    required this.name,
    required this.params,
    this.additionalParams,
  });
}
