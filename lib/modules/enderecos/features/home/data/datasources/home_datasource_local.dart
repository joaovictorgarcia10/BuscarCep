import 'package:clean_arch_aula/modules/enderecos/features/home/data/datasources/home_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/models/endereco_model.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/entities/endereco.dart';

class HomeDatasourceLocal implements HomeDatasource {
  @override
  Future<Either<Failure, EnderecoModel>> buscarEndreco(
      {required String cep}) async {
    try {
      final endereco = EnderecoModel(
        bairro: "Charminster",
        cep: "49035-470",
        complemento: "",
        ddd: "44",
        localidade: "Bournemouth",
        logradouro: "Malmesbury Park Road",
        uf: "UK",
        userId: "1",
        documentReference: null,
      );

      return Right(endereco);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }

  @override
  Future<Either<Failure, bool>> disconnetAccount() async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }

  @override
  Future<Either<Failure, bool>> saveEndereco(
      {required Endereco endereco}) async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }
}
