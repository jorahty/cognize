import 'package:cognize/screens/home/screen.dart';
import 'package:cognize/screens/login/screen.dart';
import 'package:cognize/screens/topics/screen.dart';
import 'package:cognize/screens/about/screen.dart';
import 'package:cognize/screens/profile/screen.dart';

final routes = {
  '/': (context) => const HomeScreen(),
  '/login': (context) => const LoginScreen(),
  '/topics': (context) => const TopicsScreen(),
  '/about': (context) => const AboutScreen(),
  '/profile': (context) => const ProfileScreen(),
};
