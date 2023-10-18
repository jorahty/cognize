import 'package:cognize/screens/home/screen.dart';
import 'package:cognize/screens/login/screen.dart';
import 'package:cognize/screens/topics/screen.dart';

final routes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
};
