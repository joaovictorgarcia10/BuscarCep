import 'package:dartz/dartz.dart';
import 'package:buscar_cep/modules/enderecos/features/home/data/datasources/home_datasource_local.dart';
import 'package:buscar_cep/modules/enderecos/features/home/data/datasources/home_datasource_remote.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/custom_repository/custom_repository.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';

class HomeRepositoryImpl implements HomeRepository {
  final HomeDatasourceRemote datasourceRemote;
  final HomeDatasourceLocal datasourceLocal;
  final CustomRepository customRepository;

  HomeRepositoryImpl({
    required this.datasourceRemote,
    required this.datasourceLocal,
    required this.customRepository,
  });

  @override
  Future<Either<Failure, Endereco>> buscarEndereco(
      {required String cep}) async {
    return customRepository.selectRepository(
      local: () => datasourceLocal.buscarEndreco(cep: cep),
      remote: () => datasourceRemote.buscarEndreco(cep: cep),
    );
  }

  @override
  Future<Either<Failure, bool>> saveEndereco(
      {required Endereco endereco}) async {
    return customRepository.selectRepository(
      local: () => datasourceLocal.saveEndereco(endereco: endereco),
      remote: () => datasourceRemote.saveEndereco(endereco: endereco),
    );
  }

  @override
  Future<Either<Failure, bool>> disconnet() {
    return customRepository.selectRepository(
      local: () => datasourceLocal.disconnetAccount(),
      remote: () => datasourceRemote.disconnetAccount(),
    );
  }
}
