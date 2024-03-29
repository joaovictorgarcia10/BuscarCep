import 'package:buscar_cep/modules/auth/domain/repositories/auth_repository.dart';
import 'package:buscar_cep/modules/auth/domain/usecases/create_account.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/cadastro/bloc/cadastro_state.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late AuthRepository authRepository;
  late CreateAccount createAccount;

  setUp(() {
    authRepository = MockAuthRepository();
    createAccount = CreateAccount(repository: authRepository);
  });

  group("CreateAccount", () {
    test("CreateAccount - Success", () async {
      when(
        () => authRepository.createAccount(
          email: "email",
          password: "password",
        ),
      ).thenAnswer((_) async => const Right(true));

      final result = createAccount(
          CreateAccountParams(email: "email", password: "password"));

      expectLater(
          result,
          emitsInOrder(const [
            CadastroState.loading(),
            CadastroState.success(),
          ]));
    });

    test("CreateAccount - Failure", () async {
      final failure = Failure();
      when(() => authRepository.createAccount(
          email: "email",
          password: "password")).thenAnswer((_) async => Left(failure));

      final result = createAccount(
          CreateAccountParams(email: "email", password: "password"));

      expectLater(
          result,
          emitsInOrder([
            const CadastroState.loading(),
            CadastroState.failure(failure: failure),
          ]));
    });
  });
}
