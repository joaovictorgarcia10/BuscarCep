import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:clean_arch_aula/shared/core/custom_usecase/custom_usecase.dart';

class DeleteEndereco
    implements StreamUseCase<DetalhesEnderecoState, DeleteEnderecoParams> {
  final MeusEnderecosRepository _repository;
  DeleteEndereco(this._repository);

  @override
  Stream<DetalhesEnderecoState> call(DeleteEnderecoParams params) async* {
    yield const DetalhesEnderecoState.loading();

    final result = await _repository.deleteEndereco(idEndereco: params.id);

    yield result.fold(
      (l) => DetalhesEnderecoState.failure(failure: l),
      (r) => const DetalhesEnderecoState.deleteEnderecoSuccess(),
    );
  }
}

class DeleteEnderecoParams {
  final String id;

  DeleteEnderecoParams({
    required this.id,
  });
}
