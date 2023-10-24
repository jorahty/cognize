import 'package:cognize/pages/about/page.dart';
import 'package:cognize/pages/create/page.dart';
import 'package:cognize/pages/profile/page.dart';
import 'package:cognize/pages/topics/page.dart';
import 'package:cognize/widgets/common/pressable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/pages/home/drawer.dart';
import 'package:cognize/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user!;

    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(), // Fetch topics
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final topics = snapshot.data!;
          return Scaffold(
            appBar: AppBar(
              title: const Text('Cognize'),
              leading: Builder(
                builder: (BuildContext context) => IconButton(
                  icon: const Icon(FontAwesomeIcons.bars),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              ),
              actions: [
                Pressable(
                  onPressed: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (BuildContext context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Image.network(user.photoURL!),
                ),
              ],
            ),
            drawer: HomeDrawer(topics: topics),
            body: _Body(topics: topics),
          );
        }
      },
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({required this.topics});

  final List<Topic> topics;

  @override
  State<_Body> createState() => _BodyState();
}

class _BodyState extends State<_Body> {
  var _selectedIndex = 0;

  _selectIndex(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      TopicsPage(topics: widget.topics),
      const AboutPage(),
      const CreatePage(),
    ];

    final navBarItems = [
      NavBarItem(
        isSelected: _selectedIndex == 0,
        onPressed: () => _selectIndex(0),
        icon: const Icon(FontAwesomeIcons.graduationCap),
        label: 'Topics',
      ),
      NavBarItem(
        isSelected: _selectedIndex == 1,
        onPressed: () => _selectIndex(1),
        icon: const Icon(FontAwesomeIcons.bolt),
        label: 'About',
      ),
      NavBarItem(
        isSelected: _selectedIndex == 2,
        onPressed: () => _selectIndex(2),
        icon: const Icon(FontAwesomeIcons.circlePlus),
        label: 'Create',
      ),
    ];

    final platform = Theme.of(context).platform;

    final onMobile =
        platform == TargetPlatform.iOS || platform == TargetPlatform.android;

    if (onMobile) {
      return Column(
        children: [
          Expanded(child: pages[_selectedIndex]),
          Row(
            children: navBarItems.map((item) => Expanded(child: item)).toList(),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Column(children: navBarItems),
          Expanded(child: pages[_selectedIndex]),
        ],
      );
    }
  }
}

class NavBarItem extends StatelessWidget {
  const NavBarItem({
    super.key,
    required this.isSelected,
    required this.onPressed,
    required this.icon,
    required this.label,
  });

  final bool isSelected;
  final VoidCallback onPressed;
  final Icon icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPressed: onPressed,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        child: SafeArea(
            child: Column(
          children: [
            icon,
            const SizedBox(height: 7),
            Text(label),
          ],
        )),
      ),
    );
  }
}

// class _Body extends StatelessWidget {
//   const _Body({required this.topics});

//   final List<Topic> topics;

//   @override
//   Widget build(BuildContext context) {
//     final platform = Theme.of(context).platform;

//     if (platform == TargetPlatform.iOS || platform == TargetPlatform.android) {
//       return _MobileLayout(topics: topics);
//     } else {
//       return _DesktopLayout(topics: topics);
//     }
//   }
// }

// class _MobileLayout extends StatelessWidget {
//   const _MobileLayout({required this.topics});

//   final List<Topic> topics;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Expanded(child: TopicGrid(topics: topics)),
//         BottomNavigationBar(
//           items: const [
//             BottomNavigationBarItem(
//               icon: Icon(FontAwesomeIcons.house, size: 18),
//               label: 'Topics',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(FontAwesomeIcons.boltLightning, size: 18),
//               label: 'About',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(FontAwesomeIcons.solidCircleUser, size: 18),
//               label: 'Profile',
//             ),
//             BottomNavigationBarItem(
//               icon: Icon(FontAwesomeIcons.solidCircleUser, size: 18),
//               label: 'Create',
//             )
//           ],
//           onTap: (value) {
//             if (value == 1) {
//               Navigator.pushNamed(context, '/about');
//             } else if (value == 2) {
//               Navigator.pushNamed(context, '/profile');
//             }
//           },
//         ),
//       ],
//     );
//   }
// }

// class _DesktopLayout extends StatelessWidget {
//   const _DesktopLayout({required this.topics});

//   final List<Topic> topics;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         NavigationRail(
//           labelType: NavigationRailLabelType.all,
//           selectedIndex: 0,
//           destinations: const [
//             NavigationRailDestination(
//               icon: Icon(FontAwesomeIcons.house),
//               label: Text('Topics'),
//             ),
//             NavigationRailDestination(
//               icon: Icon(FontAwesomeIcons.boltLightning),
//               label: Text('About'),
//             ),
//             NavigationRailDestination(
//               icon: Icon(FontAwesomeIcons.solidCircleUser),
//               label: Text('Profile'),
//             ),
//           ],
//           onDestinationSelected: (value) {
//             if (value == 1) {
//               Navigator.pushNamed(context, '/about');
//             } else if (value == 2) {
//               Navigator.pushNamed(context, '/profile');
//             }
//           },
//         ),
//         Expanded(child: TopicGrid(topics: topics)),
//       ],
//     );
//   }
// }
