import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/modules/auth/data/datasources/auth_datasource_firebase.dart';
import 'package:clean_arch_aula/modules/auth/data/datasources/auth_datasource_local.dart';
import 'package:clean_arch_aula/modules/auth/domain/entities/user.dart';
import 'package:clean_arch_aula/modules/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_aula/shared/core/custom_repository/custom_repository_settings.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasourceFirebase datasourceFirebase;
  final AuthDatasourceLocal datasourceLocal;
  final CustomRepositorySettings repositorySettings;

  AuthRepositoryImpl({
    required this.datasourceFirebase,
    required this.datasourceLocal,
    required this.repositorySettings,
  });

  @override
  Future<Either<Failure, User>> doLogin(
      {required String email, required String password}) async {
    return repositorySettings.selectRepository(
      local: () => datasourceLocal.doLogin(
        email: email,
        password: password,
      ),
      remote: () => datasourceFirebase.doLogin(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> createAccount(
      {required String email, required String password}) {
    return repositorySettings.selectRepository(
      local: () => datasourceLocal.createAccount(
        email: email,
        password: password,
      ),
      remote: () => datasourceFirebase.createAccount(
        email: email,
        password: password,
      ),
    );
  }

  @override
  Future<Either<Failure, bool>> resetPassword({required String email}) {
    return repositorySettings.selectRepository(
      local: () => datasourceLocal.resetPassword(email: email),
      remote: () => datasourceFirebase.resetPassword(email: email),
    );
  }
}
