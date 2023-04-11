import 'package:buscar_cep/modules/auth/domain/usecases/reset_password.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:buscar_cep/modules/auth/presentation/pages/esqueci_senha/bloc/esqueci_senha_event.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/esqueci_senha/bloc/esqueci_senha_state.dart';

class EsqueciSenhaBloc extends Bloc<EsqueciSenhaEvent, EsqueciSenhaState> {
  final ResetPassword _resetPassword;

  EsqueciSenhaBloc(
    this._resetPassword,
  ) : super(const EsqueciSenhaState.empty()) {
    on<EsqueciSenhaEvent>(_onEvent);
  }

  Future<void> _onEvent(
    EsqueciSenhaEvent event,
    Emitter<EsqueciSenhaState> emit,
  ) async {
    await event.when(
      resetPassword: (email) {
        return emit.onEach<EsqueciSenhaState>(
          _resetPassword(email),
          onData: (data) => emit(data),
        );
      },
    );
  }
}
