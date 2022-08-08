import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_state.dart';
import 'package:clean_arch_aula/shared/core/usecase/usecase_core.dart';

class GetListaEnderecos implements StreamUseCase<MeusEnderecosState, NoParams> {
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
