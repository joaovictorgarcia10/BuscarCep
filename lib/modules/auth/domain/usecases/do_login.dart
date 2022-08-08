import 'package:clean_arch_aula/modules/auth/domain/repositories/auth_repository.dart';
import 'package:clean_arch_aula/modules/auth/presentation/pages/login/bloc/login_state.dart';
import 'package:clean_arch_aula/shared/core/usecase/usecase_core.dart';

class DoLogin extends StreamUseCase<DoLoginState, DoLoginParams> {
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
