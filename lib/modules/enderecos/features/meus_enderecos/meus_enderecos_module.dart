import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource_local.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/data/datasources/meus_enderecos_datasource_remote.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/data/repositories/meus_enderecos_repository_impl.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/delete_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/get_lista_enderecos.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/detalhes_endereco_page.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/informar_numeracao/informar_numeracao_page.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/meus_enderecos_page.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/get_geolocation.dart';
import 'package:buscar_cep/shared/core/custom_repository/custom_repository.dart';
import 'package:buscar_cep/shared/utils/geolocation/geolocation_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';

class MeusEnderecosModule extends Module {
  @override
  final List<Bind> binds = [
    // Datasources
    Bind(
      (i) => MeusEnderecosDatasourceRemote(
        firebaseFirestore: FirebaseFirestore.instance,
      ),
    ),
    Bind((i) => MeusEnderecosDatasourceLocal()),

    //Repository
    Bind(
      (i) => MeusEnderecosRepositoryImpl(
        datasourceRemote: i<MeusEnderecosDatasourceRemote>(),
        datasourceLocal: i<MeusEnderecosDatasourceLocal>(),
        customRepository: i<CustomRepository>(),
      ),
    ),

    // UseCases
    Bind((i) => GetListaEnderecos(i<MeusEnderecosRepositoryImpl>())),
    Bind((i) => DeleteEndereco(i<MeusEnderecosRepositoryImpl>())),
    Bind((i) => GetGeolocation(i<GeolocationService>())),

    // Blocs
    BlocBind.singleton((i) => MeusEnderecosBloc(i<GetListaEnderecos>())),
    BlocBind.singleton(
      (i) => DetalhesEnderecoBloc(
        i<DeleteEndereco>(),
        i<GetGeolocation>(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute("/", child: (context, args) => const MeusEnderecosPage()),
    ChildRoute(
      "/detalhes",
      child: (context, args) => DetalhesEnderecoPage(
        endereco: args.data["endereco"],
        heroTag: args.data["heroTag"],
      ),
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 800),
    ),
    ChildRoute(
      "/informar_numeracao",
      child: (context, args) => InformarNumeracaoPage(
        endereco: args.data["endereco"],
        latitude: args.data["latitude"],
        longitude: args.data["longitude"],
      ),
      transition: TransitionType.fadeIn,
      duration: const Duration(milliseconds: 300),
    )
  ];
}
