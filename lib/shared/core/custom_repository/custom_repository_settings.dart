import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class CustomRepositorySettings {
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

class DevRepositorySettings extends CustomRepositorySettings {
  @override
  String get repository => "local";
}

class HmlRepositorySettings extends CustomRepositorySettings {
  @override
  String get repository => "remote";
}

class ProdRepositorySettings extends CustomRepositorySettings {
  @override
  String get repository => "remote";
}

// class TestRepositorySettings extends CustomRepositorySettings {
//   bool _localMode = true;

//   void useLocal() => _localMode = true;
//   void useRemote() => _localMode = false;

//   @override
//   String get repository => _localMode ? "local" : "remote";
// }
