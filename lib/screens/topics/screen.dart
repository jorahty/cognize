import 'package:cognize/widgets/common/pressable.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/widgets/topic/grid.dart';
import 'package:cognize/screens/topics/drawer.dart';
import 'package:cognize/services/auth.dart';

class TopicsScreen extends StatelessWidget {
  const TopicsScreen({super.key});

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
              leading: Row(
                children: [
                  Builder(
                      builder: (BuildContext context) => IconButton(
                            icon: const Icon(FontAwesomeIcons.bars),
                            onPressed: () => Scaffold.of(context).openDrawer(),
                          )),
                ],
              ),
              actions: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(user.photoURL!),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/profile');
                      },
                      child: Text(user.displayName!),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
              ],
            ),
            drawer: TopicsDrawer(topics: topics),
            body: _Body(topics: topics),
          );
        }
      },
    );
  }
}

class _Body extends StatefulWidget {
  const _Body({super.key, required this.topics});

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
      TopicGrid(topics: widget.topics),
      TopicGrid(topics: widget.topics),
      TopicGrid(topics: widget.topics),
    ];

    final navBarItems = [
      NavBarItem(isSelected: _selectedIndex == 0, onTap: () => _selectIndex(0)),
      NavBarItem(isSelected: _selectedIndex == 1, onTap: () => _selectIndex(1)),
      NavBarItem(isSelected: _selectedIndex == 2, onTap: () => _selectIndex(2)),
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
    required this.onTap,
  });

  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Pressable(
      onPressed: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        color: isSelected
            ? Theme.of(context).colorScheme.primary
            : Colors.transparent,
        child: const SafeArea(child: Icon(FontAwesomeIcons.house)),
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
