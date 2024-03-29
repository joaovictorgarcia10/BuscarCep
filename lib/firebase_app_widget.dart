// ignore_for_file: avoid_print
import 'package:buscar_cep/app_widget.dart';
import 'package:buscar_cep/shared/utils/constants/app_theme.dart';
import 'package:buscar_cep/shared/widgets/cards/error_card/error_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

enum FirebaseStatus {
  loading,
  error,
  success,
}

class FirebaseAppWidget extends StatefulWidget {
  const FirebaseAppWidget({Key? key}) : super(key: key);

  @override
  FirebaseAppWidgetState createState() => FirebaseAppWidgetState();
}

class FirebaseAppWidgetState extends State<FirebaseAppWidget> {
  final firebaseStatus = ValueNotifier<FirebaseStatus>(FirebaseStatus.loading);

  Future<void> _initApplication() async {
    try {
      firebaseStatus.value = FirebaseStatus.loading;
      await Firebase.initializeApp();
      firebaseStatus.value = FirebaseStatus.success;
      print("Firebase Started!");
    } on FirebaseException catch (_) {
      firebaseStatus.value = FirebaseStatus.error;
      rethrow;
    } catch (e) {
      firebaseStatus.value = FirebaseStatus.error;
      rethrow;
    }
  }

  @override
  void initState() {
    super.initState;
    _initApplication();
  }

  @override
  void dispose() {
    firebaseStatus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: firebaseStatus,
      builder: (_, value_, ___) {
        if (firebaseStatus.value == FirebaseStatus.error) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().appTheme(),
            home: ErrorCardWidget(
              onTapButton: () => _initApplication(),
              message:
                  "Houve uma falha de conexão, mas já estamos trabalhando para corrigir este problema, por favor, tente novamente mais tarde.",
            ),
          );
        } else if (firebaseStatus.value == FirebaseStatus.success) {
          return const AppWidget();
        } else {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme().appTheme(),
            home: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
