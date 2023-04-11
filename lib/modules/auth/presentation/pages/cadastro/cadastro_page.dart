import 'dart:async';
import 'package:buscar_cep/modules/auth/domain/usecases/create_account.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/cadastro/bloc/cadastro_bloc.dart';
import 'package:buscar_cep/modules/auth/presentation/pages/cadastro/bloc/cadastro_event.dart';
import 'package:buscar_cep/shared/utils/constants/app_colors.dart';
import 'package:buscar_cep/shared/utils/validators/app_form_validadors.dart';
import 'package:buscar_cep/shared/widgets/general/button/button_widget.dart';
import 'package:buscar_cep/shared/widgets/modals/loading_modal/loading_modal_widget.dart';
import 'package:buscar_cep/shared/widgets/general/text_form_field/text_form_field_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class CadastroPage extends StatefulWidget {
  const CadastroPage({Key? key}) : super(key: key);

  @override
  State<CadastroPage> createState() => _CadastroPageState();
}

class _CadastroPageState extends State<CadastroPage> {
  TextEditingController emailText = TextEditingController();
  TextEditingController passwordText = TextEditingController();
  TextEditingController confirmPasswordText = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  bool obscureTextPassword = true;
  bool obscureTextConfirmPassword = true;

  late StreamSubscription subscription;
  final _bloc = Modular.get<CadastroBloc>();

  @override
  void initState() {
    super.initState();

    subscription = _bloc.stream.listen((state) {
      state.maybeWhen(
        loading: () {
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                top: Radius.circular(25.0),
              ),
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
        success: () {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Usuário cadastrado com sucesso!")));
          Navigator.pop(context);
        },
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    emailText.dispose();
    passwordText.dispose();
    confirmPasswordText.dispose();
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cadastro"),
        elevation: 5,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: SizedBox(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormFieldWidget(
                      controller: emailText,
                      label: "Email",
                      prefixIcon: Icons.email_outlined,
                      validator: (text) =>
                          AppFormValidadors().emailValidator(text),
                    ),
                    const SizedBox(height: 10.0),
                    TextFormFieldWidget(
                      controller: passwordText,
                      label: "Senha",
                      prefixIcon: Icons.vpn_key_outlined,
                      obscureText: obscureTextPassword,
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
                    const SizedBox(height: 10.0),
                    TextFormFieldWidget(
                      controller: confirmPasswordText,
                      label: "Confirmar Senha",
                      prefixIcon: Icons.vpn_key_outlined,
                      obscureText: obscureTextConfirmPassword,
                      suffixIcon: obscureTextConfirmPassword
                          ? Icons.visibility_off_outlined
                          : Icons.visibility_outlined,
                      onTapSuffixIcon: () {
                        setState(() {
                          obscureTextConfirmPassword =
                              !obscureTextConfirmPassword;
                        });
                      },
                      validator: (text) =>
                          AppFormValidadors().confirmPasswordValidator(
                        confirmPassword: text,
                        password: passwordText.text,
                      ),
                    ),
                    const SizedBox(height: 50.0),
                    ButtonWidget(
                      title: "Cadastrar",
                      color: AppColors.green,
                      onTap: () {
                        if (_formKey.currentState!.validate()) {
                          _bloc.add(
                            CadastroEvent.createAccount(
                              params: CreateAccountParams(
                                email: emailText.text,
                                password: passwordText.text,
                              ),
                            ),
                          );
                        }
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
