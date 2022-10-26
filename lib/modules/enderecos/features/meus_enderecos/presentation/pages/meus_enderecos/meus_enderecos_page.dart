import 'dart:async';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_event.dart';
import 'package:clean_arch_aula/modules/enderecos/features/meus_enderecos/presentation/pages/meus_enderecos/bloc/meus_enderecos_state.dart';
import 'package:clean_arch_aula/modules/enderecos/shared/entities/endereco.dart';
import 'package:clean_arch_aula/shared/widgets/modals/error_modal/error_modal_widget.dart';
import 'package:clean_arch_aula/shared/widgets/cards/info_card/info_card_widget.dart';
import 'package:clean_arch_aula/shared/widgets/general/list_tile/list_tile_widget.dart';
import 'package:clean_arch_aula/shared/widgets/modals/loading_modal/loading_modal_widget.dart';
import 'package:clean_arch_aula/shared/widgets/cards/message_card/message_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'bloc/meus_enderecos_bloc.dart';

class MeusEnderecosPage extends StatefulWidget {
  const MeusEnderecosPage({Key? key}) : super(key: key);

  @override
  State<MeusEnderecosPage> createState() => _MeusEnderecosPageState();
}

class _MeusEnderecosPageState extends State<MeusEnderecosPage> {
  final bloc = Modular.get<MeusEnderecosBloc>();
  late StreamSubscription subscription;

  @override
  void initState() {
    super.initState();
    bloc.add(const MeusEnderecosEvent.getListaEnderecos());

    subscription = bloc.stream.listen((state) {
      state.maybeWhen(
        loading: () => showModalBottomSheet(
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
        ),
        failure: (failure) {
          Navigator.pop(context);
          showModalBottomSheet(
            context: context,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(22.0),
                topRight: Radius.circular(22.0),
              ),
            ),
            builder: (context) => ErrorModalWidget(message: failure.message),
          );
        },
        getListaEnderecosSuccess: (listaEnderecos) {
          Navigator.pop(context);
        },
        orElse: () {},
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MeusEnderecosBloc, MeusEnderecosState>(
        bloc: bloc,
        builder: (context, state) {
          return state.maybeWhen(
            getListaEnderecosSuccess: (listaEnderecos) {
              if (listaEnderecos.isNotEmpty) {
                List<String> listaCidades = [];

                for (var e in listaEnderecos) {
                  if (e.localidade != null) listaCidades.add(e.localidade!);
                }

                return NestedScrollView(
                  floatHeaderSlivers: true,
                  headerSliverBuilder: (context, innerBoxIsScrolled) {
                    return [
                      SliverAppBar(
                        expandedHeight: 250.0,
                        centerTitle: false,
                        forceElevated: true,
                        pinned: true,
                        floating: true,
                        snap: true,
                        title: const Text('Meus Endereços'),
                        flexibleSpace: FlexibleSpaceBar(
                          background: Container(
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("assets/images/img2.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 5.0,
                                  vertical: 20.0,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InfoCardWidget(
                                      title: "Endereços",
                                      value: listaEnderecos.length.toString(),
                                    ),
                                    const SizedBox(width: 30.0),
                                    InfoCardWidget(
                                      title: "Cidades",
                                      value: listaCidades
                                          .toSet()
                                          .length
                                          .toString(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ];
                  },
                  body: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                      top: 20.0,
                    ),
                    child: ListView.builder(
                      shrinkWrap: true,
                      itemCount: listaEnderecos.length,
                      itemBuilder: (context, index) {
                        Endereco endereco = listaEnderecos[index];
                        return ListTileWidget(
                          height: 80.0,
                          leadingIcon: Icons.location_on_outlined,
                          title: "${endereco.logradouro}",
                          subtitle:
                              "${endereco.bairro},  ${endereco.localidade} - ${endereco.ddd}",
                          trailingIcon: Icons.keyboard_arrow_right_outlined,
                          onTapTrailing: () {
                            Modular.to
                                .pushNamed("./detalhes", arguments: endereco);
                          },
                        );
                      },
                    ),
                  ),
                );
              }
              return const Center(
                child: MessageCardWidget(
                  message: "Você não tem nenhum endereço salvo.",
                ),
              );
            },
            orElse: () => Container(),
          );
        },
      ),
    );
  }
}
