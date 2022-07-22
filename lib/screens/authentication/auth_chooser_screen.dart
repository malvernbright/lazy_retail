import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

import 'login.dart';
import 'signup.dart';

class AuthScreenChooser extends StatelessWidget {
  const AuthScreenChooser({Key? key}) : super(key: key);
  static const String id = 'auth_chooser';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/trolley.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Lottie.asset('assets/animations/stores.json'),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      color: Theme.of(context).primaryColorDark,
                      onPressed: () {
                        Navigator.pushNamed(context, LoginScreen.id);
                      },
                      child: const Text('LOGIN')),
                  const SizedBox(width: 4),
                  MaterialButton(
                      minWidth: MediaQuery.of(context).size.width * 0.4,
                      color: Theme.of(context).primaryColor,
                      onPressed: () {
                        Navigator.pushNamed(context, SignUpPage.id);
                      },
                      child: const Text('SIGN UP')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
