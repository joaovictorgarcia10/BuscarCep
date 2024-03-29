import 'package:buscar_cep/modules/enderecos/shared/entities/endereco.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'meus_enderecos_state.freezed.dart';

@freezed
class MeusEnderecosState with _$MeusEnderecosState {
  const factory MeusEnderecosState.empty() = _$MeusEnderecosStateEmpty;
  const factory MeusEnderecosState.loading() = _$MeusEnderecosStateLoading;
  const factory MeusEnderecosState.failure({required Failure failure}) =
      _$MeusEnderecosStateFailure;
  const factory MeusEnderecosState.getListaEnderecosSuccess(
          {required List<Endereco> listaEnderecos}) =
      _$MeusEnderecosStateGetListaEnderecosSuccess;
}
