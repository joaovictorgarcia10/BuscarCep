import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/delete_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/get_geolocation.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_event.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:buscar_cep/shared/utils/geolocation/geolocation.dart';
import 'package:buscar_cep/shared/utils/geolocation/geolocation_service.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMeusEnderecosRepository extends Mock
    implements MeusEnderecosRepository {}

class MockGeolocationService extends Mock implements GeolocationService {}

void main() {
  late GeolocationService geolocationService;
  late MeusEnderecosRepository repository;

  late DeleteEndereco deleteEndereco;
  late GetGeolocation getGeolocation;

  late DetalhesEnderecoBloc bloc;

  setUp(() {
    geolocationService = MockGeolocationService();
    repository = MockMeusEnderecosRepository();

    deleteEndereco = DeleteEndereco(repository);
    getGeolocation = GetGeolocation(geolocationService);

    bloc = DetalhesEnderecoBloc(deleteEndereco, getGeolocation);
  });

  group("GetGeolocation", () {
    test("GetGeolocation - success", () {
      final geolocation = Geolocation(latitude: 1.0, longitude: 2.0);

      when(() => geolocationService.getGeolocation())
          .thenAnswer((_) async => Right(geolocation));

      bloc.add(const DetalhesEnderecoEvent.getGeolocation());

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.getGeoLocationSuccess(
              geolocation: geolocation,
            ),
          ],
        ),
      );
    });

    test("GetGeolocation - failure", () {
      final failure = Failure();

      when(() => geolocationService.getGeolocation())
          .thenAnswer((_) async => Left(failure));

      bloc.add(const DetalhesEnderecoEvent.getGeolocation());

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.failure(failure: failure),
          ],
        ),
      );
    });
  });

  group("DeleteEndereco", () {
    test("DeleteEndereco - success", () {
      when(() => repository.deleteEndereco(idEndereco: "01"))
          .thenAnswer((_) async => const Right(true));

      bloc.add(DetalhesEnderecoEvent.deleteEndereco(
          params: DeleteEnderecoParams(id: "01")));

      expectLater(
        bloc.stream,
        emitsInOrder(
          const [
            DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.deleteEnderecoSuccess(),
          ],
        ),
      );
    });

    test("DisconnectAccount - failure", () {
      final failure = Failure();

      when(() => repository.deleteEndereco(idEndereco: "01"))
          .thenAnswer((_) async => Left(failure));

      bloc.add(DetalhesEnderecoEvent.deleteEndereco(
          params: DeleteEnderecoParams(id: "01")));

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.failure(failure: failure),
          ],
        ),
      );
    });
  });
}
