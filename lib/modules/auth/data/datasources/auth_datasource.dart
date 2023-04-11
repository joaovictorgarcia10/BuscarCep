import 'package:buscar_cep/modules/auth/data/models/user_model.dart';
import 'package:dartz/dartz.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';

abstract class AuthDatasource {
  Future<Either<Failure, UserModel>> doLogin(
      {required String email, required String password});

  Future<Either<Failure, bool>> createAccount(
      {required String email, required String password});

  Future<Either<Failure, bool>> resetPassword({required String email});
}
