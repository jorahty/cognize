import 'package:cognize/pages/about/page.dart';
import 'package:cognize/pages/create/quiz_setting_page.dart';
import 'package:cognize/pages/home/search_state.dart';
import 'package:cognize/pages/profile/page.dart';
import 'package:cognize/pages/topics/page.dart';
import 'package:cognize/widgets/common/pressable.dart';
import 'package:cognize/widgets/helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cognize/services/models.dart';
import 'package:cognize/services/firestore.dart';
import 'package:cognize/pages/home/drawer.dart';
import 'package:cognize/services/auth.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final user = AuthService().user!;

    return FutureBuilder<List<Topic>>(
      future: FirestoreService().getTopics(), // Fetch topics
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
              body: Center(child: CircularProgressIndicator()));
        } else {
          final topics = snapshot.data!;

          return ChangeNotifierProvider(
            create: (_) => SearchState(),
            child: Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [
                    SvgPicture.asset('assets/logo.svg', height: 30),
                    const SizedBox(
                        width: 16), // Add spacing between logo and search bar
                    const SearchBar(),
                  ],
                ),
                actions: [
                  Pressable(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (BuildContext context) =>
                              const ProfilePage(),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: ClipOval(child: Image.network(user.photoURL!)),
                    ),
                  ),
                ],
              ),
              drawer: HomeDrawer(topics: topics),
              body: _Body(topics: topics),
              floatingActionButton: FloatingActionButton(
                backgroundColor: const Color(0xff2A66FF),
                child: const Icon(Icons.chat), // Icon for the FAB
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (BuildContext context) => const CognizeHelper(),
                    ),
                  );
                },
              ),
            ),
          );
        }
      },
    );
  }
}

class SearchBar extends StatelessWidget {
  const SearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    final searchState = Provider.of<SearchState>(context);

    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: TextField(
          controller: searchState.controller,
          onChanged: searchState.setInput,
          decoration: const InputDecoration(
            hintText: 'Search...',
          ),
          onSubmitted: (String value) {
            // Handle the search query here
          },
        ),
      ),
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
      QuizSettingsPage(),
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
          Container(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Row(
              children:
                  navBarItems.map((item) => Expanded(child: item)).toList(),
            ),
          ),
        ],
      );
    } else {
      return Row(
        children: [
          Container(
            color: Theme.of(context).colorScheme.surfaceVariant,
            child: Column(children: navBarItems),
          ),
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
        width: 80,
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
