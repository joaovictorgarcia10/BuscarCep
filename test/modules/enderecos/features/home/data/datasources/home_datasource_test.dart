import 'package:buscar_cep/modules/enderecos/features/home/data/datasources/home_datasource.dart';
import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockHomeDatasourceImpl extends Mock implements HomeDatasource {}

void main() {
  late HomeDatasource datasource;

  setUp(() async {
    datasource = MockHomeDatasourceImpl();
  });

  group("buscarEndreco", () {
    test("buscarEndreco - success", () async {
      final endereco = EnderecoModel();

      when(() => datasource.buscarEndreco(cep: "123456"))
          .thenAnswer((_) async => Right(endereco));

      final result = await datasource.buscarEndreco(cep: "123456");

      result.fold(
        (l) => null,
        (r) => expect(r, endereco),
      );
    });

    test("buscarEndreco - failure", () async {
      final failure = Failure();

      when(() => datasource.buscarEndreco(cep: "123456"))
          .thenAnswer((_) async => Left(failure));

      final result = await datasource.buscarEndreco(cep: "123456");

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });

  group("saveEndereco", () {
    test("saveEndereco - success", () async {
      final endereco = EnderecoModel();

      when(() => datasource.saveEndereco(endereco: endereco))
          .thenAnswer((_) async => const Right(true));

      final result = await datasource.saveEndereco(endereco: endereco);

      result.fold(
        (l) => null,
        (r) => expect(r, true),
      );
    });

    test("saveEndereco - failure", () async {
      final failure = Failure();
      final endereco = EnderecoModel();

      when(() => datasource.saveEndereco(endereco: endereco))
          .thenAnswer((_) async => Left(failure));

      final result = await datasource.saveEndereco(endereco: endereco);

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });

  group("disconnetAccount", () {
    test("disconnetAccount - success", () async {
      when(() => datasource.disconnetAccount())
          .thenAnswer((_) async => const Right(true));

      final result = await datasource.disconnetAccount();

      result.fold(
        (l) => null,
        (r) => expect(r, true),
      );
    });

    test("disconnetAccount - failure", () async {
      final failure = Failure();

      when(() => datasource.disconnetAccount())
          .thenAnswer((_) async => Left(failure));

      final result = await datasource.disconnetAccount();

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });
}
