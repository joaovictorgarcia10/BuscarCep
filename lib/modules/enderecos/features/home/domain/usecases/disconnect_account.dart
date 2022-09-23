import 'package:clean_arch_aula/modules/enderecos/features/home/domain/repositories/home_repository.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_state.dart';
import 'package:clean_arch_aula/shared/core/custom_usecase/custom_usecase.dart';

class DisconnectAccount implements StreamUseCase<HomeState, NoParams> {
  final HomeRepository _repository;
  DisconnectAccount(this._repository);

  @override
  Stream<HomeState> call([NoParams? params]) async* {
    yield const HomeState.loading();

    final result = await _repository.disconnet();

    yield result.fold(
      (l) => HomeState.failure(failure: l),
      (r) => const HomeState.disconnectAccountSuccess(),
    );
  }
}
