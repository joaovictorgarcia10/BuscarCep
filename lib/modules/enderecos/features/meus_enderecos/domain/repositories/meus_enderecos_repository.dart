import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class MeusEnderecosRepository {
  Future<Either<Failure, List<Endereco>>> getListaEnderecos();
  Future<Either<Failure, bool>> deleteEndereco({required String idEndereco});
}
