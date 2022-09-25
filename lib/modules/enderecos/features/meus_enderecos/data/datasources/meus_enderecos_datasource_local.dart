import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/models/endereco_model.dart';

class MeusEnderecosDatasourceLocal implements MeusEnderecosDatasource {
  @override
  Future<Either<Failure, bool>> deleteEndereco({required String idEndereco}) {
    // TODO: implement deleteEndereco
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<EnderecoModel>>> getListaEnderecos() {
    // TODO: implement getListaEnderecos
    throw UnimplementedError();
  }
}
