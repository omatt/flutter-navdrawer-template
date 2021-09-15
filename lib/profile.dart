import 'package:flutter/material.dart';
import 'package:meme/main.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key, required this.title, required this.navigatorKey}) : super(key: key);
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Profile',
            ),
            ElevatedButton(
              child: const Text('View Details'),
              onPressed: () {
                widget.navigatorKey.currentState!.pushNamed(Nemo.post);
              },
            ),
          ],
        ),
      ),
    );
  }
}