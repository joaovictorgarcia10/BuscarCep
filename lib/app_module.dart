import 'package:clean_arch_aula/modules/auth/auth_module.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/home_module.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/meus_enderecos_module.dart';
import 'package:clean_arch_aula/shared/features/geolocation/data/services/geolocation_service_impl.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:clean_arch_aula/shared/features/geolocation/data/repositories/geolocation_repository_impl.dart';

class AppModule extends Module {
  @override
  final List<Bind> binds = [
    // Geolocation
    Bind((i) => GeolocationServiceImpl()),
    Bind((i) => GeolocationRepositoryImpl(i<GeolocationServiceImpl>())),
  ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/meus_enderecos", module: MeusEnderecosModule()),
  ];
}
