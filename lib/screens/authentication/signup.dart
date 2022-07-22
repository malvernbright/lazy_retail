import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../custom_widgets/custom_text_form_field.dart';
import '../../models/user.dart';
import '../../state/providers/auth_provider.dart';
import '../../utils/constants.dart';
import '../main/welcome_screen.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key? key, required this.title}) : super(key: key);
  final String title;
  static const String id = 'sign_up';

  static final TextEditingController _nameController = TextEditingController();
  static final TextEditingController _passwordController =
      TextEditingController();
  static final TextEditingController _passwordConfirmController =
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
                    height: MediaQuery.of(context).size.height * 0.5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(.8),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: const EdgeInsets.all(20.0),
                    margin: const EdgeInsets.all(20.0),
                    child: ListView(
                      children: [
                        AnimatedTextKit(
                          repeatForever: true,
                          animatedTexts: [
                            TypewriterAnimatedText('Lazy Retail',
                                speed: const Duration(milliseconds: 100),
                                textStyle: textStyle2),
                            TypewriterAnimatedText('SIGN UP',
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
                        buildTextFormField(
                          hintText: 'Password Confirm',
                          controller: _passwordConfirmController,
                          obscureText: true,
                          borderHintFocusTextColor: Colors.white,
                          fillColor: Colors.black,
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColorDark,
                          onPressed: () {
                            _formKey.currentState!.validate();
                            if (_formKey.currentState!.validate()) {
                              if (_passwordController.text ==
                                  _passwordConfirmController.text) {
                                User user = User(
                                    name: _nameController.text,
                                    password: _passwordController.text);
                                provider
                                    .signUp(user)
                                    .then((value) => provider.isLoggedIn
                                        ? Navigator.pushReplacementNamed(
                                            context, WelcomeScreen.id)
                                        : null)
                                    .then((value) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          '${_nameController.text} was created successfully!'),
                                    ),
                                  );
                                });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Error'),
                                    content:
                                        const Text('Passwords do not match'),
                                    actions: [
                                      TextButton(
                                        child: const Text('OK'),
                                        onPressed: () => Navigator.pop(context),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            }
                          },
                          shape: const StadiumBorder(
                            side: BorderSide(
                              color: Colors.white,
                              width: 2.0,
                            ),
                          ),
                          child: const Text('Signup'),
                        ),
                      ],
                    )),
              ),
            );
          },
        ),
      ),
    );
  }
}
