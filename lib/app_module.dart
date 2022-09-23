import 'package:flutter_modular/flutter_modular.dart';
import 'package:clean_arch_aula/modules/auth/auth_module.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/home_module.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/meus_enderecos_module.dart';
import 'package:clean_arch_aula/shared/core/custom_repository/custom_repository_settings.dart';
import 'package:clean_arch_aula/shared/utils/geolocation/data/repositories/geolocation_repository_impl.dart';
import 'package:clean_arch_aula/shared/utils/geolocation/data/services/geolocation_service_impl.dart';

class AppModule extends Module {
  final String env;

  AppModule({required this.env}) {
    _repositorySettings();
  }

  @override
  List<Bind> get binds => [
        Bind((i) => _repositorySettings()),
        Bind((i) => GeolocationServiceImpl()),
        Bind((i) => GeolocationServiceImpl()),
        Bind((i) => GeolocationRepositoryImpl(i<GeolocationServiceImpl>())),
      ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/meus_enderecos", module: MeusEnderecosModule()),
  ];

  CustomRepositorySettings _repositorySettings() {
    switch (env) {
      case "hml":
        return HmlRepositorySettings();
      case "dev":
        return DevRepositorySettings();
      default:
        return ProdRepositorySettings();
    }
  }
}
