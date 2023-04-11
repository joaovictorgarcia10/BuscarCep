import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/get_lista_enderecos.dart';
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
  late GetListaEnderecos usecase;

  setUp(() {
    repository = MockMeusEnderecosRepository();
    usecase = GetListaEnderecos(repository);
  });

  group("GetListaEnderecos", () {
    test("GetListaEnderecos - Success", () async {
      final enderecos = <Endereco>[];

      when(
        () => repository.getListaEnderecos(),
      ).thenAnswer((_) async => Right(enderecos));

      final result = usecase();

      expectLater(
        result,
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

    test("GetListaEnderecos - Failure", () async {
      final failure = Failure();

      when(() => repository.getListaEnderecos())
          .thenAnswer((_) async => Left(failure));

      final result = usecase();

      expectLater(
        result,
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
