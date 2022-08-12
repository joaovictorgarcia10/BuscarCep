import 'package:clean_arch_aula/shared/features/geolocation/data/services/geolocation_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocationService extends Mock implements GeolocationService {}

void main() {
  late GeolocationService geolocationService;

  setUp(() {
    geolocationService = MockGeolocationService();
  });

  group("GeolocationService Test", () {
    test("GeolocationService - Success", () {});

    test("GeolocationService - Failure", () {});
  });
}
