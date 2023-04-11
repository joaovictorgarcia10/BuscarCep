import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, Endereco>> buscarEndereco({required String cep});
  Future<Either<Failure, bool>> saveEndereco({required Endereco endereco});
  Future<Either<Failure, bool>> disconnet();
}
