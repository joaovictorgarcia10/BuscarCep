import 'package:clean_arch_aula/modules/auth/domain/entities/user.dart';
import 'package:clean_arch_aula/modules/auth/domain/repositories/auth_repository.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';

class AuthDatasourceLocal extends AuthRepository {
  @override
  Future<Either<Failure, bool>> createAccount(
      {required String email, required String password}) async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }

  @override
  Future<Either<Failure, User>> doLogin(
      {required String email, required String password}) async {
    try {
      final user = User(
        email: "devflutter@buscarcep.com",
        nome: "Dev Flutter",
        photoUrl: "",
        userId: "12345",
      );

      if (email == "devflutter@buscarcep.com" && password == "123456") {
        return Right(user);
      } else {
        return Left(Failure(message: UserNotFoundFailure().message));
      }
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }

  @override
  Future<Either<Failure, bool>> resetPassword({required String email}) async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }
}
