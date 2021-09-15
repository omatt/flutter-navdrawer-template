import 'package:flutter/material.dart';
import 'package:meme/main.dart';
import 'package:meme/post.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key, required this.title, required this.navigatorKey}) : super(key: key);
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              'Home',
            ),
            ElevatedButton(
              child: const Text('View Details'),
              onPressed: () {
                var args = PostDetails(id: '1234');
                debugPrint('Clicked Post button ${args.id}');
                widget.navigatorKey.currentState!.pushNamed(Nemo.post, arguments: args);
              },
            ),
          ],
        ),
      ),
    );
  }
}