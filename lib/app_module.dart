import 'package:clean_arch_aula/shared/utils/geolocation/geolocation_service.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:clean_arch_aula/modules/auth/auth_module.dart';
import 'package:clean_arch_aula/modules/enderecos/features/home/home_module.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/meus_enderecos_module.dart';
import 'package:clean_arch_aula/shared/core/custom_repository/custom_repository.dart';

class AppModule extends Module {
  final String env;

  AppModule({required this.env}) {
    _repositorySettings();
  }

  @override
  List<Bind> get binds => [
        Bind((i) => _repositorySettings()),
        Bind((i) => GeolocationService()),
      ];

  @override
  final List<ModularRoute> routes = [
    ModuleRoute(Modular.initialRoute, module: AuthModule()),
    ModuleRoute("/home", module: HomeModule()),
    ModuleRoute("/meus_enderecos", module: MeusEnderecosModule()),
  ];

  CustomRepository _repositorySettings() {
    switch (env) {
      case "hml":
        return HmlRepository();
      case "dev":
        return DevRepository();
      default:
        return ProdRepository();
    }
  }
}
