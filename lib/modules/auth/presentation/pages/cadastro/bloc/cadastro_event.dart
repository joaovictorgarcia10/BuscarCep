import 'package:buscar_cep/modules/auth/domain/usecases/create_account.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'cadastro_event.freezed.dart';

@freezed
class CadastroEvent with _$CadastroEvent {
  const factory CadastroEvent.createAccount(
      {required CreateAccountParams params}) = _$CadastroEventCreateAccount;
}
