import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class MeusEnderecosDatasource {
  Future<Either<Failure, List<EnderecoModel>>> getListaEnderecos();
  Future<Either<Failure, bool>> deleteEndereco({required String idEndereco});
}
