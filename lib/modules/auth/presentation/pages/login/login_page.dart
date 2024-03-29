import 'dart:async';
import 'package:buscar_cep/modules/auth/domain/usecases/do_login.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_bloc.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/login/bloc/login_event.dart';
import 'package:buscar_cep/shared/utils/constants/app_colors.dart';
import 'package:buscar_cep/shared/utils/constants/app_text_styles.dart';
import 'package:buscar_cep/shared/utils/validators/app_form_validadors.dart';
import 'package:buscar_cep/shared/widgets/general/button/button_widget.dart';
import 'package:buscar_cep/shared/widgets/modals/loading_modal/loading_modal_widget.dart';
import 'package:buscar_cep/shared/widgets/general/text_form_field/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _bloc = Modular.get<LoginBloc>();
  late StreamSubscription subscription;

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool obscureTextPassword = true;

  @override
  void initState() {
    super.initState();
    subscription = _bloc.stream.listen((state) {
      state.maybeWhen(
        success: (user) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Seja bem vindo! ${user.email}"),
            ),
          );

          Modular.to.pushReplacementNamed("/home");
        },
        loading: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(top: Radius.circular(25.0)),
            ),
            isDismissible: false,
            isScrollControlled: false,
            enableDrag: false,
            builder: (context) => const LoadingModalWidget(),
          );
        },
        failure: (failure) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(failure.message.toString())));
        },
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    subscription.cancel();
    emailTextController.dispose();
    passwordTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 60.0),
              Row(
                children: const [
                  Hero(
                    tag: "location_icon_tag",
                    child: Icon(
                      Icons.location_on_outlined,
                      size: 52.0,
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Text(
                    "Bem vindo ao\nBuscar CEP",
                    style: AppTextStyles.title,
                  ),
                ],
              ),
              const SizedBox(height: 80.0),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      controller: emailTextController,
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      validator: (text) =>
                          AppFormValidadors().emailValidator(text),
                    ),
                    TextFormFieldWidget(
                      controller: passwordTextController,
                      label: "Senha",
                      obscureText: obscureTextPassword,
                      keyboardType: TextInputType.text,
                      prefixIcon: Icons.vpn_key_outlined,
                      suffixIcon: obscureTextPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onTapSuffixIcon: () {
                        setState(() {
                          obscureTextPassword = !obscureTextPassword;
                        });
                      },
                      validator: (text) =>
                          AppFormValidadors().passwordValidator(text),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 5.0),
              Align(
                alignment: Alignment.centerRight,
                child: InkWell(
                  child: const Text("Esqueci minha senha"),
                  onTap: () {
                    Modular.to.pushNamed("/esqueci_senha");
                  },
                ),
              ),
              const SizedBox(height: 60.0),
              ButtonWidget(
                title: "Entrar",
                color: AppColors.green,
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    _bloc.add(
                      DoLoginEvent.login(
                        params: DoLoginParams(
                          email: emailTextController.text,
                          password: passwordTextController.text,
                        ),
                      ),
                    );
                  }
                },
              ),
              const SizedBox(height: 20.0),
              ButtonWidget(
                title: "Inscrever-se",
                color: Colors.transparent,
                borderColor: AppColors.white,
                onTap: () => Modular.to.pushNamed("/cadastro"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
