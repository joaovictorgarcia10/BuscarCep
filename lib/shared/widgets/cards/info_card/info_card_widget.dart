import 'package:buscar_cep/shared/utils/constants/app_text_styles.dart';
import 'package:flutter/material.dart';

class InfoCardWidget extends StatelessWidget {
  final String title;
  final String value;

  const InfoCardWidget({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 20.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22.0)),
      color: Colors.black12.withOpacity(0.6),
      borderOnForeground: true,
      child: SizedBox(
        height: 100,
        width: 150,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                value,
                style: AppTextStyles.inputText,
              ),
              const SizedBox(height: 5.0),
              Text(
                title,
                style: AppTextStyles.inputText,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
