import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:cognize/widgets/common/button.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                SvgPicture.asset(
                  'assets/logo.svg',
                  width: 280,
                ),
                const SizedBox(height: 50),
                SizedBox(
                  width: 300,
                  child: Text(
                    "A platform where users can evaluate their knowledge and skills",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Button(
                  onPressed: () {
                    launchUrl(Uri.parse('https://cognize.dev/slides.pdf'));
                  },
                  leading: const Icon(FontAwesomeIcons.circleInfo),
                  label: const Text('Learn More'),
                ),
                const SizedBox(width: 20),
                Button(
                  onPressed: () {
                    launchUrl(Uri.parse('https://github.com/jorahty/cognize'));
                  },
                  leading: const Icon(FontAwesomeIcons.github),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
