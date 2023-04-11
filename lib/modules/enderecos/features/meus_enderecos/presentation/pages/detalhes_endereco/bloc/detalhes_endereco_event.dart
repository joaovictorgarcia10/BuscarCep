import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/delete_endereco.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'detalhes_endereco_event.freezed.dart';

@freezed
class DetalhesEnderecoEvent with _$DetalhesEnderecoEvent {
  const factory DetalhesEnderecoEvent.deleteEndereco(
          {required DeleteEnderecoParams params}) =
      _$DetalhesEnderecoEventDeleteEndereco;
  const factory DetalhesEnderecoEvent.getGeolocation() =
      _$DetalhesEnderecoEventGetGeolocation;
}
