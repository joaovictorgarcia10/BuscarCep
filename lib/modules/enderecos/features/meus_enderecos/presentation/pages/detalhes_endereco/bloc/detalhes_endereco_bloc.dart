import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/delete_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/get_geolocation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'detalhes_endereco_event.dart';

class DetalhesEnderecoBloc
    extends Bloc<DetalhesEnderecoEvent, DetalhesEnderecoState> {
  final DeleteEndereco _deleteEndereco;
  final GetGeolocation _getGeolocation;

  DetalhesEnderecoBloc(
    this._deleteEndereco,
    this._getGeolocation,
  ) : super(const DetalhesEnderecoState.empty()) {
    on<DetalhesEnderecoEvent>(_onEvent);
  }

  Future<void> _onEvent(
      DetalhesEnderecoEvent event, Emitter<DetalhesEnderecoState> emit) async {
    await event.when(
      deleteEndereco: (params) async {
        return emit.onEach<DetalhesEnderecoState>(
          _deleteEndereco(params),
          onData: (data) => emit(data),
        );
      },
      getGeolocation: () async {
        return emit.onEach<DetalhesEnderecoState>(
          _getGeolocation(),
          onData: (data) => emit(data),
        );
      },
    );
  }
}
