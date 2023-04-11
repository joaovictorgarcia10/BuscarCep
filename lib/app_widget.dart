import 'package:buscar_cep/shared/core/custom_env/custom_env.dart';
import 'package:buscar_cep/shared/utils/constants/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner:
          (CustomEnv.get("ENV") != "dev") ? false : true,
      title: 'Buscar Cep App',
      theme: AppTheme().appTheme(),
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
    );
  }
}
