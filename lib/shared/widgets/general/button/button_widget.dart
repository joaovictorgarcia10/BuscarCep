import 'package:flutter/material.dart';

import 'package:buscar_cep/shared/utils/constants/app_text_styles.dart';

class ButtonWidget extends StatelessWidget {
  final String title;
  final Color color;
  final Color? borderColor;
  final VoidCallback onTap;

  const ButtonWidget({
    Key? key,
    required this.title,
    required this.color,
    this.borderColor,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(32.0),
      onTap: onTap,
      child: Container(
        height: 50.0,
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: borderColor ?? Colors.transparent,
          ),
          color: color,
          borderRadius: BorderRadius.circular(32.0),
        ),
        child: Center(
          child: Text(
            title,
            style: AppTextStyles.inputText,
          ),
        ),
      ),
    );
  }
}
