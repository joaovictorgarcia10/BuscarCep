import 'package:buscar_cep/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';

class BuscarEndreco implements StreamUseCase<HomeState, BuscarEndrecoParams> {
  final HomeRepository _repository;
  BuscarEndreco(this._repository);

  @override
  Stream<HomeState> call(BuscarEndrecoParams params) async* {
    yield const HomeState.loading();

    final result = await _repository.buscarEndereco(cep: params.cep);

    yield result.fold(
      (l) => HomeState.failure(failure: l),
      (r) => HomeState.buscarEnderecoSuccess(endereco: r),
    );
  }
}

class BuscarEndrecoParams {
  final String cep;
  BuscarEndrecoParams({required this.cep});
}
