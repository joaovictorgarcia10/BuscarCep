import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  Future<void> navigate() async {
    await Future.delayed(const Duration(seconds: 2));

    FirebaseAuth.instance.authStateChanges().listen(
      (user) {
        if (user == null) {
          Modular.to.pushReplacementNamed("/login");
        } else {
          Modular.to.pushReplacementNamed("/home");
        }
      },
    );
  }

  @override
  void initState() {
    super.initState();
    navigate();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Hero(
          tag: "location_icon_tag",
          child: Icon(
            Icons.location_on_outlined,
            size: 100.0,
          ),
        ),
      ),
    );
  }
}
