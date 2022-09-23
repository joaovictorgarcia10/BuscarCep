import 'package:clean_arch_aula/app_module.dart';
import 'package:clean_arch_aula/firebase_app_widget.dart';
import 'package:clean_arch_aula/shared/core/custom_bloc_observer/custom_bloc_observer.dart';
import 'package:clean_arch_aula/shared/core/custom_env/custom_env.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CustomEnv.load(".env");

  BlocOverrides.runZoned(
    () => runApp(
      ModularApp(
        module: AppModule(env: CustomEnv.get("ENV")),
        child: const FirebaseAppWidget(),
      ),
    ),
    blocObserver: CustomBlocObserver(),
  );
}
