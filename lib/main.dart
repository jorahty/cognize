import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cognize/util/firebase_options.dart';
import 'package:cognize/theme.dart';
import 'package:cognize/routes.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: theme,
      routes: routes,
      debugShowCheckedModeBanner: false,
    );
  }
}
