import 'package:clean_arch_aula/modules/auth/domain/usecases/do_login.dart';
import 'package:clean_arch_aula/modules/auth/presentation/pages/login/bloc/login_event.dart';
import 'package:clean_arch_aula/modules/auth/presentation/pages/login/bloc/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginBloc extends Bloc<DoLoginEvent, DoLoginState> {
  final DoLogin _doLogin;

  LoginBloc(
    this._doLogin,
  ) : super(const DoLoginState.empty()) {
    on<DoLoginEvent>(_onEvent);
  }

  Future<void> _onEvent(DoLoginEvent event, Emitter<DoLoginState> emit) async {
    await event.when(
      login: (params) {
        return emit.onEach<DoLoginState>(
          _doLogin(params),
          onData: (data) => emit(data),
        );
      },
    );
  }
}
