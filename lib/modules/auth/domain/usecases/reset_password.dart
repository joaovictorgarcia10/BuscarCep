import 'package:buscar_cep/modules/auth/domain/repositories/auth_repository.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';

import '../../presentation/pages/esqueci_senha/bloc/esqueci_senha_state.dart';

class ResetPassword extends CustomUsecase<EsqueciSenhaState, String> {
  final AuthRepository repository;
  ResetPassword({required this.repository});

  @override
  Stream<EsqueciSenhaState> call(String params) async* {
    yield const EsqueciSenhaState.loading();

    final result = await repository.resetPassword(email: params);

    yield result.fold(
      (l) => EsqueciSenhaState.failure(failure: l),
      (r) => const EsqueciSenhaState.success(),
    );
  }
}
