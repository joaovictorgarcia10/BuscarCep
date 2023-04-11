abstract class CustomUsecase<Type, Params> {
  Stream<Type> call(Params params);
}

class NoParams {}
