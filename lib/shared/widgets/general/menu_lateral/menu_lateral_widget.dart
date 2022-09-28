import 'package:flutter/material.dart';
import 'package:clean_arch_aula/shared/utils/constants/app_colors.dart';
import 'package:clean_arch_aula/shared/utils/constants/app_text_styles.dart';

class MenuLateralWidget extends StatefulWidget {
  final Widget options;
  final String? nome;
  final String? email;

  const MenuLateralWidget({
    Key? key,
    required this.options,
    required this.nome,
    required this.email,
  }) : super(key: key);

  @override
  State<MenuLateralWidget> createState() => _MenuLateralWidgetState();
}

class _MenuLateralWidgetState extends State<MenuLateralWidget> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomRight: Radius.circular(32.0),
            topRight: Radius.circular(32.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              DrawerHeader(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          width: 1,
                          color: AppColors.white,
                        ),
                        borderRadius: BorderRadius.circular(52.0),
                      ),
                      child: Center(
                          child: Text(
                        widget.email?.substring(0, 1).toUpperCase() ?? "",
                        style: AppTextStyles.title,
                      )),
                    ),
                    const SizedBox(height: 10.0),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(widget.nome ?? ""),
                        const SizedBox(height: 5.0),
                        Text(widget.email ?? ""),
                      ],
                    )
                  ],
                ),
              ),
              const SizedBox(height: 10.0),
              widget.options,
            ],
          ),
        ),
      ),
    );
  }
}
