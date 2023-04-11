import 'package:buscar_cep/modules/enderecos/features/home/data/datasources/home_datasource_local.dart';
import 'package:buscar_cep/modules/enderecos/features/home/data/datasources/home_datasource_remote.dart';
import 'package:buscar_cep/modules/enderecos/features/home/data/repositories/home_repository_impl.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/buscar_endreco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/disconnect_account.dart';
import 'package:buscar_cep/modules/enderecos/features/home/domain/usecases/save_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/bloc/home_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/home/presentation/pages/home_page/home_page.dart';
import 'package:buscar_cep/shared/core/custom_repository/custom_repository.dart';
import 'package:buscar_cep/shared/core/services/http/dio_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class HomeModule extends Module {
  @override
  final List<Bind> binds = [
    // Datasources
    Bind(
      (i) => HomeDatasourceRemote(
        httpService: DioService(),
        firebaseFirestore: FirebaseFirestore.instance,
        firebaseAuth: FirebaseAuth.instance,
      ),
    ),
    Bind((i) => HomeDatasourceLocal()),

    //Repository
    Bind((i) => HomeRepositoryImpl(
          datasourceLocal: i<HomeDatasourceLocal>(),
          datasourceRemote: i<HomeDatasourceRemote>(),
          customRepository: i<CustomRepository>(),
        )),

    // UseCases
    Bind((i) => BuscarEndreco(i<HomeRepositoryImpl>())),
    Bind((i) => SaveEndereco(i<HomeRepositoryImpl>())),
    Bind((i) => DisconnectAccount(i<HomeRepositoryImpl>())),

    // Blocs
    BlocBind.singleton(
      (i) => HomeBloc(
        i<BuscarEndreco>(),
        i<SaveEndereco>(),
        i<DisconnectAccount>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => const HomePage()),
  ];
}
