import 'package:clean_arch_aula/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/entities/endereco.dart';
import 'package:clean_arch_aula/shared/core/custom_usecase/custom_usecase.dart';

class SaveEndereco implements StreamUseCase<HomeState, Endereco> {
  final HomeRepository _repository;
  SaveEndereco(this._repository);

  @override
  Stream<HomeState> call(Endereco params) async* {
    yield const HomeState.loading();

    final result = await _repository.saveEndereco(endereco: params);

    yield result.fold(
      (l) => HomeState.failure(failure: l),
      (r) => const HomeState.saveEnderecoSuccess(),
    );
  }
}
