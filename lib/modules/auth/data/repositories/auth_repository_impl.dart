import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/modules/auth/data/datasources/auth_datasource_remote.dart';
import 'package:clean_arch_aula/modules/auth/data/datasources/auth_datasource_local.dart';
import 'package:clean_arch_aula/modules/auth/domain/entities/user.dart';
import 'package:clean_arch_aula/modules/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_aula/shared/core/custom_repository/custom_repository.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasourceRemote datasourceRemote;
  final AuthDatasourceLocal datasourceLocal;
  final CustomRepository customRepository;

  AuthRepositoryImpl({
    required this.datasourceRemote,
    required this.datasourceLocal,
    required this.customRepository,
  });

  @override
  Future<Either<Failure, User>> doLogin(
      {required String email, required String password}) async {
    return customRepository.selectRepository(
      local: () => datasourceLocal.doLogin(
        email: email,
        password: password,
      ),
      remote: () => datasourceRemote.doLogin(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> createAccount(
      {required String email, required String password}) {
    return customRepository.selectRepository(
      local: () => datasourceLocal.createAccount(
        email: email,
        password: password,
      ),
      remote: () => datasourceRemote.createAccount(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> resetPassword({required String email}) {
    return customRepository.selectRepository(
      local: () => datasourceLocal.resetPassword(email: email),
      remote: () => datasourceRemote.resetPassword(email: email),
    );
  }
}
