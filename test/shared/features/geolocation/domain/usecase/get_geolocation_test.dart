import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/domain/usecases/get_geolocation.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/shared/features/geolocation/domain/entities/geolocation.dart';
import 'package:clean_arch_aula/shared/features/geolocation/domain/repositories/geolocation_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockGeolocationRepository extends Mock implements GeolocationRepository {}

void main() {
  late GetGeolocation getGeolocation;
  late GeolocationRepository geolocationRepository;

  setUp(() {
    geolocationRepository = MockGeolocationRepository();
    getGeolocation = GetGeolocation(geolocationRepository);
  });

  group("GetGeolocation", () {
    test("GetGeolocation - Success", () async {
      final geolocation = Geolocation(latitude: 0, longitude: 0);

      when(() => geolocationRepository.getGeolocation())
          .thenAnswer((_) async => Right(geolocation));

      final result = getGeolocation();

      expectLater(
          result,
          emitsInOrder([
            const DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.getGeoLocationSuccess(
              geolocation: geolocation,
            ),
          ]));
    });

    test("GetGeolocation - Failure", () {
      final failure = Failure();

      when(() => geolocationRepository.getGeolocation())
          .thenAnswer((_) async => Left(failure));

      final result = getGeolocation();

      expectLater(
          result,
          emitsInOrder([
            const DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.failure(failure: failure),
          ]));
    });
  });
}
