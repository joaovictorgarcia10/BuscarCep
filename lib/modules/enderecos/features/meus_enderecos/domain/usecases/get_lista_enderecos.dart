import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_state.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';

class GetListaEnderecos implements CustomUsecase<MeusEnderecosState, NoParams> {
  final MeusEnderecosRepository _meusEnderecosRepository;
  GetListaEnderecos(this._meusEnderecosRepository);

  @override
  Stream<MeusEnderecosState> call([NoParams? params]) async* {
    yield const MeusEnderecosState.loading();

    final result = await _meusEnderecosRepository.getListaEnderecos();

    yield result.fold(
      (l) => MeusEnderecosState.failure(failure: l),
      (r) => MeusEnderecosState.getListaEnderecosSuccess(listaEnderecos: r),
    );
  }
}
