import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:clean_arch_aula/shared/utils/constants/app_text_styles.dart';

class MessageCardWidget extends StatelessWidget {
  final String message;
  final bool withButton;

  const MessageCardWidget({
    Key? key,
    required this.message,
    this.withButton = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          height: 100.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                message,
                style: AppTextStyles.listTileTitle,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 5.0),
              if (withButton)
                TextButton(
                  onPressed: () => Modular.to.pop(),
                  child: const Text("Voltar"),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
