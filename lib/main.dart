import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(useMaterial3: true),
      home: Scaffold(
        body: Center(
          child: Row(
            children: [
              const CircularProgressIndicator(),
              FilledButton(
                onPressed: () {},
                child: const Text('Hello, World!'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
