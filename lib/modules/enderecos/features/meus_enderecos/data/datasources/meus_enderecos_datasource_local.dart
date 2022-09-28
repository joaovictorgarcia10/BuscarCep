import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource.dart';
import 'package:dartz/dartz.dart';
import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/models/endereco_model.dart';

class MeusEnderecosDatasourceLocal implements MeusEnderecosDatasource {
  @override
  Future<Either<Failure, bool>> deleteEndereco(
      {required String idEndereco}) async {
    try {
      return const Right(true);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }

  @override
  Future<Either<Failure, List<EnderecoModel>>> getListaEnderecos() async {
    try {
      final enderecos = <EnderecoModel>[
        EnderecoModel(
          bairro: "Charminster",
          cep: "49035-470",
          complemento: "Casa de andar",
          ddd: "44",
          localidade: "Bournemouth",
          logradouro: "Malmesbury Park Road",
          uf: "UK",
          userId: "1",
          documentReference: null,
        ),
        EnderecoModel(
          bairro: "Atalaia",
          cep: "49035-470",
          complemento: "Casa de esquina",
          ddd: "79",
          localidade: "Aracaju",
          logradouro: "Rua José Steremberg",
          uf: "SE",
          userId: "1",
          documentReference: null,
        ),
      ];

      return Right(enderecos);
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }
}
