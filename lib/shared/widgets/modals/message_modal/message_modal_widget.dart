import 'package:buscar_cep/shared/utils/constants/app_colors.dart';
import 'package:buscar_cep/shared/utils/constants/app_text_styles.dart';
import 'package:buscar_cep/shared/widgets/general/button/button_widget.dart';
import 'package:flutter/material.dart';

class MessageModalWidget extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback? onDismiss;

  const MessageModalWidget({
    Key? key,
    required this.message,
    required this.onConfirm,
    this.onDismiss,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message, style: AppTextStyles.bodyText),
              const SizedBox(height: 40.0),
              ButtonWidget(
                title: "Sim",
                onTap: onConfirm,
                color: AppColors.green,
              ),
              const SizedBox(height: 15.0),
              ButtonWidget(
                title: "Não",
                onTap: onDismiss ?? () => Navigator.pop(context),
                color: Colors.transparent,
                borderColor: AppColors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
