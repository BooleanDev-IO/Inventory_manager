import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../repos/models/user.dart';
import '../../../reusable_widgets/profile_widgets/button_widget.dart';
import '../../../reusable_widgets/profile_widgets/numbers_widget.dart';
import '../../../reusable_widgets/profile_widgets/profile_widget.dart';

class UserPreferences {
  static const myUser = User(
    imagePath: 'https://images.unsplash.com/photo-1554151228-14d9def656e4?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=333&q=80',
    name: 'Username',
    email: 'user@email.com',
    about:
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Nulla tincidunt auctor nulla quis mattis. Integer gravida velit libero, eu imperdiet justo vulputate quis. Suspendisse potenti. In facilisis malesuada leo, non dapibus erat venenatis quis. Donec tortor ipsum, maximus at ultricies in, blandit sit amet nulla. Proin id rhoncus urna, a pharetra metus. Quisque ullamcorper lorem vitae velit finibus congue eu id ipsum.',
    isDarkMode: false,
  );
}

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    final user = UserPreferences.myUser;

    return Container(
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
        padding: const EdgeInsets.all(36),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(36), color: AdaptiveTheme.of(context).mode.isDark ? Colors.black54 : Colors.deepPurple.shade100),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ProfileWidget(
                  imagePath: user.imagePath,
                  onClicked: () {
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(builder: (context) => EditProfilePage()),
                    // );
                  },
                ),
                const SizedBox(height: 24),
                buildName(user),
                const SizedBox(height: 24),
                Center(child: buildUpgradeButton()),
                const SizedBox(height: 24),
                NumbersWidget(),
                const SizedBox(height: 48),
                buildAbout(user),
              ],
            ),
          ),
        ));
  }

  Widget buildName(User user) => Column(
        children: [
          Text(
            user.name,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 4),
          Text(
            user.email,
            style: TextStyle(color: Colors.grey),
          )
        ],
      );

  Widget buildUpgradeButton() => ButtonWidget(
        text: 'Star Performer',
        onClicked: () {},
      );

  Widget buildAbout(User user) => Container(
        padding: EdgeInsets.symmetric(horizontal: 48),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'About',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Text(
              user.about,
              style: TextStyle(fontSize: 16, height: 1.4),
            ),
          ],
        ),
      );
}
