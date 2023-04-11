import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/repositories/meus_enderecos_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';

class DeleteEndereco
    implements CustomUsecase<DetalhesEnderecoState, DeleteEnderecoParams> {
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
