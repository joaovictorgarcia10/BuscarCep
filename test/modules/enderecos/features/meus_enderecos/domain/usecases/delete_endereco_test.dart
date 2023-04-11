import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/delete_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
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
  late DeleteEndereco usecase;

  setUp(() {
    repository = MockMeusEnderecosRepository();
    usecase = DeleteEndereco(repository);
  });

  group("GetListaEnderecos", () {
    test("GetListaEnderecos - Success", () async {
      when(
        () => repository.deleteEndereco(idEndereco: "01"),
      ).thenAnswer((_) async => const Right(true));

      final result = usecase(DeleteEnderecoParams(id: "01"));

      expectLater(
        result,
        emitsInOrder(
          const [
            DetalhesEnderecoState.loading(),
            DetalhesEnderecoState.deleteEnderecoSuccess(),
          ],
        ),
      );
    });

    test("GetListaEnderecos - Failure", () async {
      final failure = Failure();

      when(
        () => repository.deleteEndereco(idEndereco: "01"),
      ).thenAnswer((_) async => Left(failure));

      final result = usecase(DeleteEnderecoParams(id: "01"));

      expectLater(
        result,
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
