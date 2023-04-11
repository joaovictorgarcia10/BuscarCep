import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'package:dartz/dartz.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';

abstract class HomeDatasource {
  Future<Either<Failure, EnderecoModel>> buscarEndreco({required String cep});
  Future<Either<Failure, bool>> saveEndereco({required Endereco endereco});
  Future<Either<Failure, bool>> disconnetAccount();
}
