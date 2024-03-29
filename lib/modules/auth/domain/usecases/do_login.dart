import 'package:buscar_cep/modules/auth/domain/repositories/auth_repository.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_state.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';

class DoLogin extends CustomUsecase<DoLoginState, DoLoginParams> {
  final AuthRepository repository;
  DoLogin({required this.repository});

  @override
  Stream<DoLoginState> call(DoLoginParams params) async* {
    yield const DoLoginState.loading();

    final result = await repository.doLogin(
      email: params.email,
      password: params.password,
    );

    yield result.fold(
      (l) => DoLoginState.failure(failure: l),
      (r) => DoLoginState.success(user: r),
    );
  }
}

class DoLoginParams {
  final String email;
  final String password;

  DoLoginParams({
    required this.email,
    required this.password,
  });
}
