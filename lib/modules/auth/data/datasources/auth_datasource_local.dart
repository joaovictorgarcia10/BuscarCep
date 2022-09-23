import 'package:clean_arch_aula/modules/auth/domain/entities/user.dart';
import 'package:clean_arch_aula/modules/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';

class AuthDatasourceLocal extends AuthRepository {
  @override
  Future<Either<Failure, bool>> createAccount(
      {required String email, required String password}) {
    // TODO: implement createAccount
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, User>> doLogin(
      {required String email, required String password}) {
    // TODO: implement doLogin
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> resetPassword({required String email}) {
    // TODO: implement resetPassword
    throw UnimplementedError();
  }
}
