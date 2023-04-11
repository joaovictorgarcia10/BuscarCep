import 'package:buscar_cep/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/buscar_endreco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/disconnect_account.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeRepository extends Mock implements HomeRepository {}

void main() {
  late HomeRepository repository;
  late DisconnectAccount usecase;

  setUp(() {
    repository = MockHomeRepository();
    usecase = DisconnectAccount(repository);
  });

  group("DisconnectAccount", () {
    test("DisconnectAccount - Success", () async {
      when(() => repository.disconnet())
          .thenAnswer((_) async => const Right(true));

      final result = usecase();

      expectLater(
          result,
          emitsInOrder(const [
            HomeState.loading(),
            HomeState.disconnectAccountSuccess(),
          ]));
    });

    test("DisconnectAccount - Failure", () async {
      final failure = Failure();

      when(() => repository.disconnet()).thenAnswer((_) async => Left(failure));

      final result = usecase();

      expectLater(
          result,
          emitsInOrder([
            const HomeState.loading(),
            HomeState.failure(failure: failure),
          ]));
    });
  });
}
