import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource.dart';
import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockMeusEnderecossourceImpl extends Mock
    implements MeusEnderecosDatasource {}

void main() {
  late MeusEnderecosDatasource datasource;

  setUp(() async {
    datasource = MockMeusEnderecossourceImpl();
  });

  group("getListaEnderecos", () {
    test("getListaEnderecos - success", () async {
      final enderecos = <EnderecoModel>[];

      when(() => datasource.getListaEnderecos())
          .thenAnswer((_) async => Right(enderecos));

      final result = await datasource.getListaEnderecos();

      result.fold(
        (l) => null,
        (r) => expect(r, enderecos),
      );
    });

    test("getListaEnderecos - failure", () async {
      final failure = Failure();

      when(() => datasource.getListaEnderecos())
          .thenAnswer((_) async => Left(failure));

      final result = await datasource.getListaEnderecos();

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });

  group("deleteEndereco", () {
    test("deleteEndereco - success", () async {
      when(() => datasource.deleteEndereco(idEndereco: "01"))
          .thenAnswer((_) async => const Right(true));

      final result = await datasource.deleteEndereco(idEndereco: "01");

      result.fold(
        (l) => null,
        (r) => expect(r, true),
      );
    });

    test("deleteEndereco - failure", () async {
      final failure = Failure();

      when(() => datasource.deleteEndereco(idEndereco: "01"))
          .thenAnswer((_) async => Left(failure));

      final result = await datasource.deleteEndereco(idEndereco: "01");

      result.fold(
        (l) => expect(l, failure),
        (r) => null,
      );
    });
  });
}
