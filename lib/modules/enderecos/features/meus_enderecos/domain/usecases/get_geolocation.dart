import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:clean_arch_aula/shared/features/geolocation/domain/repositories/geolocation_repository.dart';
import 'package:clean_arch_aula/shared/core/custom_usecase/custom_usecase.dart';

class GetGeolocation implements StreamUseCase<DetalhesEnderecoState, NoParams> {
  final GeolocationRepository _geolocationRepository;
  GetGeolocation(this._geolocationRepository);

  @override
  Stream<DetalhesEnderecoState> call([NoParams? params]) async* {
    yield const DetalhesEnderecoState.loading();

    final result = await _geolocationRepository.getGeolocation();

    yield result.fold(
      (l) => DetalhesEnderecoState.failure(failure: l),
      (r) => DetalhesEnderecoState.getGeoLocationSuccess(geolocation: r),
    );
  }
}
