import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_state.dart';
import 'package:buscar_cep/shared/core/custom_usecase/custom_usecase.dart';
import 'package:buscar_cep/shared/utils/geolocation/geolocation_service.dart';

class GetGeolocation implements CustomUsecase<DetalhesEnderecoState, NoParams> {
  final GeolocationService _geolocationService;
  GetGeolocation(this._geolocationService);

  @override
  Stream<DetalhesEnderecoState> call([NoParams? params]) async* {
    yield const DetalhesEnderecoState.loading();

    final result = await _geolocationService.getGeolocation();

    yield result.fold(
      (l) => DetalhesEnderecoState.failure(failure: l),
      (r) => DetalhesEnderecoState.getGeoLocationSuccess(geolocation: r),
    );
  }
}
