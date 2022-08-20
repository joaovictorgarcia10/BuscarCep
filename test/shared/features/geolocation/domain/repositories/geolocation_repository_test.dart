import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/shared/features/geolocation/domain/entities/geolocation.dart';
import 'package:clean_arch_aula/shared/features/geolocation/domain/repositories/geolocation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocationRepository extends Mock implements GeolocationRepository {}

void main() {
  late GeolocationRepository geolocationRepository;

  setUp(() {
    geolocationRepository = MockGeolocationRepository();
  });

  group("GeolocationRepository", () {
    test("GeolocationRepository - Success", () async {
      final geolocation = Geolocation(latitude: 0, longitude: 0);

      when(() => geolocationRepository.getGeolocation())
          .thenAnswer((_) async => Right(geolocation));

      final result = await geolocationRepository.getGeolocation();

      result.fold(
        (l) => null,
        (r) => expect(r, geolocation),
      );
    });

    test("GeolocationRepository - Failure", () async {
      final failure = Failure();

      when(() => geolocationRepository.getGeolocation())
          .thenAnswer((_) async => Left(failure));

      final result = await geolocationRepository.getGeolocation();

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });
}
