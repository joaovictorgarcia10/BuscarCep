import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/get_lista_enderecos.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_event.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_state.dart';
import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMeusEnderecosRepository extends Mock
    implements MeusEnderecosRepository {}

void main() {
  late MeusEnderecosRepository repository;
  late GetListaEnderecos getListaEnderecos;
  late MeusEnderecosBloc bloc;

  setUp(() {
    repository = MockMeusEnderecosRepository();
    getListaEnderecos = GetListaEnderecos(repository);
    bloc = MeusEnderecosBloc(getListaEnderecos);
  });

  group("DeleteEndereco", () {
    test("DeleteEndereco - success", () {
      final enderecos = <Endereco>[];

      when(() => repository.getListaEnderecos())
          .thenAnswer((_) async => Right(enderecos));

      bloc.add(const MeusEnderecosEvent.getListaEnderecos());

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const MeusEnderecosState.loading(),
            MeusEnderecosState.getListaEnderecosSuccess(
              listaEnderecos: enderecos,
            ),
          ],
        ),
      );
    });

    test("DisconnectAccount - failure", () {
      final failure = Failure();

      when(() => repository.getListaEnderecos())
          .thenAnswer((_) async => Left(failure));

      bloc.add(const MeusEnderecosEvent.getListaEnderecos());

      expectLater(
        bloc.stream,
        emitsInOrder(
          [
            const MeusEnderecosState.loading(),
            MeusEnderecosState.failure(failure: failure),
          ],
        ),
      );
    });
  });
}
