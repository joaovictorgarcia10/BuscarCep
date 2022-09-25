import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CustomRepository {
  String get repository;

  Future<Either<Failure, T>> selectRepository<T>({
    required Future<Either<Failure, T>> Function() local,
    required Future<Either<Failure, T>> Function() remote,
  }) async {
    if (repository == "local") {
      return local();
    } else {
      return remote();
    }
  }
}

class DevRepository extends CustomRepository {
  @override
  String get repository => "local";
}

class HmlRepository extends CustomRepository {
  @override
  String get repository => "remote";
}

class ProdRepository extends CustomRepository {
  @override
  String get repository => "remote";
}

// class TestRepository extends CustomRepository {
//   bool _localMode = true;

//   void useLocal() => _localMode = true;
//   void useRemote() => _localMode = false;

//   @override
//   String get repository => _localMode ? "local" : "remote";
// }
