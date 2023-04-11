import 'package:buscar_cep/modules/auth/domain/entities/user.dart';
import 'package:buscar_cep/modules/auth/domain/repositories/auth_repository.dart';
import 'package:buscar_cep/modules/auth/domain/usecases/do_login.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_bloc.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_event.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_state.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginBloc loginBloc;
  late DoLogin doLogin;
  late AuthRepository authRepository;

  setUp(() {
    authRepository = MockAuthRepository();
    doLogin = DoLogin(repository: authRepository);
    loginBloc = LoginBloc(doLogin);
  });

  group("LoginBloc", () {
    test("LoginBloc - success", () {
      final user = User(
        email: "email",
        nome: "nome",
        photoUrl: "photoUrl",
        userId: "userId",
      );

      when(() => authRepository.doLogin(email: "email", password: "password"))
          .thenAnswer((_) async => Right(user));

      loginBloc.add(DoLoginEvent.login(
          params: DoLoginParams(email: "email", password: "password")));

      expectLater(
        loginBloc.stream,
        emitsInOrder(
          [
            const DoLoginState.loading(),
            DoLoginState.success(user: user),
          ],
        ),
      );
    });

    test("LoginBloc - failure", () {
      final failure = Failure();

      when(() => authRepository.doLogin(email: "email", password: "password"))
          .thenAnswer((_) async => Left(failure));

      loginBloc.add(DoLoginEvent.login(
          params: DoLoginParams(email: "email", password: "password")));

      expectLater(
        loginBloc.stream,
        emitsInOrder(
          [
            const DoLoginState.loading(),
            DoLoginState.failure(failure: failure),
          ],
        ),
      );
    });
  });
}
