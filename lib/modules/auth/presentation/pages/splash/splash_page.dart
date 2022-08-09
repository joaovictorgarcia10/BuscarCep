import 'package:clean_arch_aula/shared/core/i18n/i18n_localizations.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final i18n = I18nLocalizations();

  Future<void> initI18n() async {
    await Future.delayed(const Duration(seconds: 3));
    await I18nLocalizations.startWithPackages(
      packages: ["app"],
      locales: [
        const Locale("pt", "BR"),
        const Locale("en", "US"),
      ],
      localeResolutionCallback: localeResolutionCallback,
    );
  }

  Locale localeResolutionCallback(locale, supportedLocales) {
    for (var supportedLocale in supportedLocales) {
      if (locale != null &&
          supportedLocale.languageCode == locale.languageCode &&
          supportedLocale.countryCode == locale.countryCode) {
        return supportedLocale;
      }
    }
    return supportedLocales.first;
  }

  @override
  void initState() {
    super.initState();
    initI18n().then((_) {
      FirebaseAuth.instance.authStateChanges().listen((user) {
        if (user == null) {
          Modular.to.pushReplacementNamed("/login");
        } else {
          Modular.to.pushReplacementNamed("/home");
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Icon(
          Icons.location_on_outlined,
          size: 100.0,
        ),
      ),
    );
  }
}
