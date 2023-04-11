import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group("EnderecoModel Test", () {
    test("Parse Model", () {
      final json = {
        "cep": "cep",
        "logradouro": "logradouro",
        "complemento": "complemento",
        "bairro": "bairro",
        "localidade": "localidade",
        "uf": "uf",
        "ddd": "ddd",
      };

      final user = EnderecoModel.fromMap(json);
      expect(user.cep, "cep");
      expect(user.logradouro, "logradouro");
      expect(user.complemento, "complemento");
      expect(user.bairro, "bairro");
      expect(user.localidade, "localidade");
      expect(user.uf, "uf");
      expect(user.ddd, "ddd");
    });
  });
}
