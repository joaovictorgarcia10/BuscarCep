import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:buscar_cep/shared/core/error/failure.dart';
import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'meus_enderecos_datasource.dart';

class MeusEnderecosDatasourceRemote implements MeusEnderecosDatasource {
  final FirebaseFirestore firebaseFirestore;
  MeusEnderecosDatasourceRemote({required this.firebaseFirestore});

  @override
  Future<Either<Failure, List<EnderecoModel>>> getListaEnderecos() async {
    try {
      final response = firebaseFirestore
          .collection("enderecos")
          .where("userId", isEqualTo: FirebaseAuth.instance.currentUser?.uid);

      final List<EnderecoModel> enderecos = await response.get().then((query) =>
          query.docs.map((e) => EnderecoModel.fromFirebase(e)).toList());

      return Right(enderecos);
    } on FirebaseException catch (_) {
      return Left(Failure(message: ServerFailure().message));
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }

  @override
  Future<Either<Failure, bool>> deleteEndereco(
      {required String idEndereco}) async {
    try {
      if (idEndereco.isNotEmpty) {
        await firebaseFirestore
            .collection("enderecos")
            .doc(idEndereco)
            .delete();

        return const Right(true);
      } else {
        return Left(Failure(message: ServerFailure().message));
      }
    } on FirebaseException catch (_) {
      return Left(Failure(message: ServerFailure().message));
    } catch (e) {
      return Left(Failure(message: ServerFailure().message));
    }
  }
}
