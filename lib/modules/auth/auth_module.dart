import 'package:buscar_cep/modules/auth/data/datasources/auth_datasource_remote.dart';
import 'package:buscar_cep/modules/auth/data/datasources/auth_datasource_local.dart';
import 'package:buscar_cep/modules/auth/domain/usecases/create_account.dart';
import 'package:buscar_cep/modules/auth/domain/usecases/reset_password.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/cadastro/bloc/cadastro_bloc.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/cadastro/cadastro_page.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/esqueci_senha/bloc/esqueci_senha_bloc.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/esqueci_senha/esqueci_senha_page.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_bloc.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/login_page.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/splash/splash_page.dart';
import 'package:buscar_cep/shared/core/custom_repository/custom_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:modular_bloc_bind/modular_bloc_bind.dart';
import 'data/repositories/auth_repository_impl.dart';
import 'domain/usecases/do_login.dart';

class AuthModule extends Module {
  @override
  final List<Bind> binds = [
    // Datasources
    Bind((i) => AuthDatasourceRemote(firebaseAuth: FirebaseAuth.instance)),
    Bind((i) => AuthDatasourceLocal()),

    //Repository
    Bind(
      (i) => AuthRepositoryImpl(
        datasourceRemote: i<AuthDatasourceRemote>(),
        datasourceLocal: i<AuthDatasourceLocal>(),
        customRepository: i<CustomRepository>(),
      ),
    ),

    // UseCases
    Bind((i) => DoLogin(repository: i<AuthRepositoryImpl>())),
    Bind((i) => CreateAccount(repository: i<AuthRepositoryImpl>())),
    Bind((i) => ResetPassword(repository: i<AuthRepositoryImpl>())),

    // Bloc
    BlocBind.singleton((i) => LoginBloc(i<DoLogin>())),
    BlocBind.singleton((i) => CadastroBloc(i<CreateAccount>())),
    BlocBind.singleton((i) => EsqueciSenhaBloc(i<ResetPassword>()))
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      "/",
      child: (context, args) => const SplashPage(),
    ),
    ChildRoute(
      "/login",
      child: (context, args) => const LoginPage(),
      transition: TransitionType.size,
      duration: const Duration(milliseconds: 1600),
    ),
    ChildRoute(
      "/cadastro",
      child: (context, args) => const CadastroPage(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    ),
    ChildRoute(
      "/esqueci_senha",
      child: (context, args) => const EsqueciSenhaPage(),
      transition: TransitionType.rightToLeft,
      duration: const Duration(milliseconds: 800),
    ),
  ];
}
