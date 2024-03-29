import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/domain/usecases/delete_endereco.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_bloc.dart';
import 'package:buscar_cep/modules/enderecos/features/meus_enderecos/presentation/pages/detalhes_endereco/bloc/detalhes_endereco_event.dart';
import 'package:buscar_cep/modules/enderecos/shared/models/endereco_model.dart';
import 'package:buscar_cep/shared/utils/constants/app_colors.dart';
import 'package:buscar_cep/shared/widgets/cards/endereco_card/endereco_card_widget.dart';
import 'package:buscar_cep/shared/widgets/general/button/button_widget.dart';
import 'package:buscar_cep/shared/widgets/modals/error_modal/error_modal_widget.dart';
import 'package:buscar_cep/shared/widgets/modals/loading_modal/loading_modal_widget.dart';
import 'package:buscar_cep/shared/widgets/modals/message_modal/message_modal_widget.dart';

class DetalhesEnderecoPage extends StatefulWidget {
  final EnderecoModel endereco;
  final String heroTag;

  const DetalhesEnderecoPage({
    Key? key,
    required this.endereco,
    required this.heroTag,
  }) : super(key: key);

  @override
  State<DetalhesEnderecoPage> createState() => _DetalhesEnderecoPageState();
}

class _DetalhesEnderecoPageState extends State<DetalhesEnderecoPage> {
  final bloc = Modular.get<DetalhesEnderecoBloc>();
  late StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _subscription = bloc.stream.listen((state) {
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
        deleteEnderecoSuccess: () {
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Endereço excluido com sucesso.')));
          Modular.to.popUntil(ModalRoute.withName('/home'));
          Modular.to.pushNamed("/meus_enderecos");
        },
        getGeoLocationSuccess: (geolocation) {
          Navigator.pop(context);
          Modular.to.pushNamed(
            "informar_numeracao",
            arguments: {
              "endereco": widget.endereco,
              "latitude": geolocation.latitude,
              "longitude": geolocation.longitude,
            },
          );
        },
        orElse: () {},
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _subscription.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Endereço'),
        elevation: 5,
      ),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              children: [
                Hero(
                  tag: widget.heroTag,
                  child: EnderecoCardWidget(endereco: widget.endereco),
                ),
                const SizedBox(height: 50.0),
                ButtonWidget(
                  title: "Ver no Mapa",
                  color: AppColors.green,
                  onTap: () {
                    bloc.add(const DetalhesEnderecoEvent.getGeolocation());
                  },
                ),
                const SizedBox(height: 20.0),
                ButtonWidget(
                  title: "Apagar Endereço",
                  color: Colors.transparent,
                  borderColor: AppColors.white,
                  onTap: () {
                    showModalBottomSheet(
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(22.0),
                          topRight: Radius.circular(22.0),
                        ),
                      ),
                      builder: (context) {
                        return MessageModalWidget(
                          message: "Quer mesmo apagar este endereço?",
                          onConfirm: () {
                            Navigator.pop(context);
                            bloc.add(
                              DetalhesEnderecoEvent.deleteEndereco(
                                params: DeleteEnderecoParams(
                                  id: widget.endereco.documentReference?.id ??
                                      "1",
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
