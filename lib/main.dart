import 'package:flutter/material.dart';
import 'package:jwtlogresflutter/pages/home_page.dart';
import 'package:jwtlogresflutter/pages/login_page.dart';
import 'package:jwtlogresflutter/pages/register_page.dart';
import 'package:jwtlogresflutter/services/shared_service.dart';

Widget defaultPage = const HomePage();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  bool result = await SharedService.isLoggedIn();
  if (result) {
    defaultPage = const HomePage();
  } else {
    defaultPage = const LoginPage();
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'JWT Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => defaultPage,
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}
