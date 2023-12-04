import 'package:cognize/widgets/auth_gate.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cognize/util/firebase_options.dart';
import 'package:provider/provider.dart';

import 'package:cognize/services/firestore.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/theme.dart';

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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    PaintingBinding.instance.imageCache.maximumSize = 150;
    PaintingBinding.instance.imageCache.maximumSizeBytes = 150 << 20;

    return StreamProvider(
      create: (_) => FirestoreService().userReportStream(),
      initialData: Report(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Cognize',
        theme: theme,
        home: const AuthGate(),
      ),
    );
  }
}
