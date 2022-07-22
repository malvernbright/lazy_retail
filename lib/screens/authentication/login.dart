import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:lazy_retail/screens/main/welcome_screen.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_text_form_field.dart';
import '../../state/providers/auth_provider.dart';
import '../../utils/constants.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String id = 'login';

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/trolley.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Consumer<AuthProvider>(
          builder: (context, provider, child) {
            return Center(
              child: Form(
                key: _formKey,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(.8),
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.all(20.0),
                  margin: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      AnimatedTextKit(
                        repeatForever: true,
                        animatedTexts: [
                          TypewriterAnimatedText('Lazy Retail',
                              speed: const Duration(milliseconds: 100),
                              textStyle: textStyle2),
                          TypewriterAnimatedText('Login',
                              speed: const Duration(milliseconds: 100),
                              textStyle: textStyle2),
                        ],
                      ),
                      buildTextFormField(
                        hintText: 'Name',
                        controller: _nameController,
                        obscureText: false,
                        borderHintFocusTextColor: Colors.white,
                        fillColor: Colors.black,
                      ),
                      buildTextFormField(
                        hintText: 'Password',
                        controller: _passwordController,
                        obscureText: true,
                        borderHintFocusTextColor: Colors.white,
                        fillColor: Colors.black,
                      ),
                      MaterialButton(
                        color: Theme.of(context).primaryColorDark,
                        onPressed: () {
                          _formKey.currentState!.validate();
                          if (_formKey.currentState!.validate()) {
                            provider
                                .login(
                              _nameController.text,
                              _passwordController.text,
                            )
                                .then((value) {
                              _nameController.clear();
                              _passwordController.clear();
                            }).then(
                              (value) => provider.isLoggedIn
                                  ? Navigator.pushReplacementNamed(
                                      context, WelcomeScreen.id)
                                  : ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                            'Wrong Credentials, try again!'),
                                      ),
                                    ),
                            );
                          }
                        },
                        shape: const StadiumBorder(
                          side: BorderSide(
                            color: Colors.white,
                            width: 2.0,
                          ),
                        ),
                        child: const Text('LOGIN'),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
