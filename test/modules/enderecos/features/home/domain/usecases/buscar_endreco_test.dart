import 'package:buscar_cep/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/buscar_endreco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repository;
  late BuscarEndreco usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = BuscarEndreco(repository);
  });

  group("BuscarEndreco", () {
    test("BuscarEndreco - Success", () async {
      final endereco = Endereco();

      when(
        () => repository.buscarEndereco(cep: "123456"),
      ).thenAnswer((_) async => Right(endereco));

      final result = usecase(BuscarEndrecoParams(cep: "123456"));

      expectLater(
          result,
          emitsInOrder([
            const HomeState.loading(),
            HomeState.buscarEnderecoSuccess(endereco: endereco),
          ]));
    });

    test("BuscarEndreco - Failure", () async {
      final failure = Failure();
      when(
        () => repository.buscarEndereco(cep: "123456"),
      ).thenAnswer((_) async => Left(failure));

      final result = usecase(BuscarEndrecoParams(cep: "123456"));

      expectLater(
          result,
          emitsInOrder([
            const HomeState.loading(),
            HomeState.failure(failure: failure),
          ]));
    });
  });
}
