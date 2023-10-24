import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/widgets/user/details.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(FontAwesomeIcons.chevronLeft),
          onPressed: () => Navigator.of(context).pop(),
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
        ),
        title: const Text('Profile'),
      ),
      body: const UserDetails(),
    );
  }
}
