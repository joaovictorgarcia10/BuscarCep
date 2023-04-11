import 'package:buscar_cep/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/buscar_endreco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/save_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repository;
  late SaveEndereco usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = SaveEndereco(repository);
  });

  group("SaveEndereco", () {
    test("SaveEndereco - Success", () async {
      final endereco = Endereco();

      when(
        () => repository.saveEndereco(endereco: endereco),
      ).thenAnswer((_) async => const Right(true));

      final result = usecase(endereco);

      expectLater(
          result,
          emitsInOrder(const [
            HomeState.loading(),
            HomeState.saveEnderecoSuccess(),
          ]));
    });

    test("SaveEndereco - Failure", () async {
      final failure = Failure();
      final endereco = Endereco();

      when(
        () => repository.saveEndereco(endereco: endereco),
      ).thenAnswer((_) async => Left(failure));

      final result = usecase(endereco);

      expectLater(
          result,
          emitsInOrder([
            const HomeState.loading(),
            HomeState.failure(failure: failure),
          ]));
    });
  });
}
