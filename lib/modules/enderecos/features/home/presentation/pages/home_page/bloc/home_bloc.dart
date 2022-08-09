import 'package:clean_arch_aula/modules/enderecos/features/home/domain/usecases/buscar_endreco.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/domain/usecases/disconnect_account.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/domain/usecases/save_endereco.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_event.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final BuscarEndreco _buscarEndreco;
  final SaveEndereco _saveEndereco;
  final DisconnectAccount _disconnectAccount;

  HomeBloc(
    this._buscarEndreco,
    this._saveEndereco,
    this._disconnectAccount,
  ) : super(const HomeState.empty()) {
    on<HomeEvent>(_onEvent);
  }

  Future<void> _onEvent(HomeEvent event, Emitter<HomeState> emit) async {
    await event.when(
      buscarEndereco: (params) {
        return emit.onEach<HomeState>(
          _buscarEndreco(params),
          onData: (data) => emit(data),
        );
      },
      saveEndereco: (endereco) {
        return emit.onEach<HomeState>(
          _saveEndereco(endereco),
          onData: (data) => emit(data),
        );
      },
      disconnectAccount: () {
        return emit.onEach<HomeState>(
          _disconnectAccount(),
          onData: (data) => emit(data),
        );
      },
    );
  }
}
