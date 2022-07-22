import 'package:flutter/material.dart';
import 'screens/authentication/auth_chooser_screen.dart';
import 'screens/authentication/signup.dart';
import 'screens/main/action_widgets_screens.dart';
import 'screens/main/welcome_screen.dart';
import 'package:provider/provider.dart';
import 'screens/authentication/login.dart';
import 'state/providers/auth_provider.dart';
import 'state/providers/stores_provider.dart';
import 'utils/helper.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  StoresDatabase().initDB();
  runApp(
    MultiProvider(providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => StoresProvider()),
    ], child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lazy Retail',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        ActionWidgetsScreen.id: (_) => const ActionWidgetsScreen(),
        AuthScreenChooser.id: (_) => const AuthScreenChooser(),
        LoginScreen.id: (_) => const LoginScreen(title: 'Login'),
        SignUpPage.id: (_) => const SignUpPage(title: 'Sign Up'),
        WelcomeScreen.id: (_) => const WelcomeScreen()
      },
      initialRoute: AuthScreenChooser.id,
    );
  }
}
