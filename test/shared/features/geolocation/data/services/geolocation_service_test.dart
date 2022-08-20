import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/shared/features/geolocation/data/services/geolocation_service.dart';
import 'package:clean_arch_aula/shared/features/geolocation/domain/entities/geolocation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocationService extends Mock implements GeolocationService {}

void main() {
  late GeolocationService geolocationService;

  setUp(() {
    geolocationService = MockGeolocationService();
  });

  group("GeolocationService Test", () {
    test("GeolocationService - Success", () async {
      final geolocation = Geolocation(latitude: 0, longitude: 0);

      when(() => geolocationService.getGeolocation())
          .thenAnswer((_) async => Right(geolocation));

      final result = await geolocationService.getGeolocation();

      result.fold(
        (l) => null,
        (r) => expect(r, geolocation),
      );
    });

    test("GeolocationService - Failure", () async {
      final failure = Failure();

      when(() => geolocationService.getGeolocation())
          .thenAnswer((_) async => Left(failure));

      final result = await geolocationService.getGeolocation();

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });
}
