import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource_local.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource_remote.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/models/endereco_model.dart';
import 'package:clean_arch_aula/shared/core/custom_repository/custom_repository.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';

class MeusEnderecosRepositoryImpl implements MeusEnderecosRepository {
  final MeusEnderecosDatasourceLocal datasourceLocal;
  final MeusEnderecosDatasourceRemote datasourceRemote;
  final CustomRepository customRepository;

  MeusEnderecosRepositoryImpl({
    required this.datasourceLocal,
    required this.datasourceRemote,
    required this.customRepository,
  });

  @override
  Future<Either<Failure, bool>> deleteEndereco({required String idEndereco}) {
    return customRepository.selectRepository(
      local: () => datasourceLocal.deleteEndereco(idEndereco: idEndereco),
      remote: () => datasourceRemote.deleteEndereco(idEndereco: idEndereco),
    );
  }

  @override
  Future<Either<Failure, List<EnderecoModel>>> getListaEnderecos() {
    return customRepository.selectRepository(
      local: () => datasourceLocal.getListaEnderecos(),
      remote: () => datasourceRemote.getListaEnderecos(),
    );
  }
}
