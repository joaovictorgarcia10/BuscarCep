import 'package:buscar_cep/modules/auth/domain/repositories/auth_repository.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/cadastro/bloc/cadastro_state.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';

class CreateAccount extends StreamUseCase<CadastroState, CreateAccountParams> {
  final AuthRepository repository;
  CreateAccount({required this.repository});

  @override
  Stream<CadastroState> call(CreateAccountParams params) async* {
    yield const CadastroState.loading();

    final result = await repository.createAccount(
      email: params.email,
      password: params.password,
    );

    yield result.fold(
      (l) => CadastroState.failure(failure: l),
      (r) => const CadastroState.success(),
    );
  }
}

class CreateAccountParams {
  final String email;
  final String password;

  CreateAccountParams({
    required this.email,
    required this.password,
  });
}
