import 'package:clean_arch_aula/modules/auth/data/datasources/auth_datasource.dart';
import 'package:clean_arch_aula/modules/auth/data/models/user_model.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockAuthDatasourceImpl extends Mock implements AuthDatasource {}

void main() {
  late AuthDatasource datasource;

  setUp(() async {
    datasource = MockAuthDatasourceImpl();
  });

  group("doLogin", () {
    test("doLogin - success", () async {
      final user = UserModel();

      when(() => datasource.doLogin(email: "email", password: "senha"))
          .thenAnswer((_) async => Right(user));

      final result = await datasource.doLogin(
        email: "email",
        password: "senha",
      );

      result.fold(
        (l) => null,
        (r) => expect(r, user),
      );
    });

    test("doLogin - failure", () async {
      final failure = Failure();

      when(
        () => datasource.doLogin(email: "email", password: "senha"),
      ).thenAnswer((_) async => Left(failure));

      final result = await datasource.doLogin(
        email: "email",
        password: "senha",
      );

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });

  group("createAccount", () {
    test("createAccount - failure", () async {
      when(
        () => datasource.createAccount(email: "email", password: "senha"),
      ).thenAnswer((_) async => const Right(true));

      final result = await datasource.createAccount(
        email: "email",
        password: "senha",
      );

      result.fold(
        (l) => null,
        (r) => expect(r, true),
      );
    });

    test("createAccount - success", () async {
      final failure = Failure();

      when(
        () => datasource.createAccount(email: "email", password: "senha"),
      ).thenAnswer((_) async => Left(failure));

      final result = await datasource.createAccount(
        email: "email",
        password: "senha",
      );

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });

  group("resetPassword", () {
    test("resetPassword - failure", () async {
      when(
        () => datasource.resetPassword(email: "email"),
      ).thenAnswer((_) async => const Right(true));

      final result = await datasource.resetPassword(
        email: "email",
      );

      result.fold(
        (l) => null,
        (r) => expect(r, true),
      );
    });

    test("resetPassword - success", () async {
      final failure = Failure();

      when(
        () => datasource.resetPassword(email: "email"),
      ).thenAnswer((_) async => Left(failure));

      final result = await datasource.resetPassword(
        email: "email",
      );

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });
}
