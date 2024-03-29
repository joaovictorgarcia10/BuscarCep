import 'package:buscar_cep/modules/auth/domain/entities/user.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepository {
  Future<Either<Failure, User>> doLogin(
      {required String email, required String password});

  Future<Either<Failure, bool>> createAccount(
      {required String email, required String password});

  Future<Either<Failure, bool>> resetPassword({required String email});
}
