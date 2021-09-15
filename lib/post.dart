import 'package:flutter/material.dart';

class PostPage extends StatefulWidget {
  const PostPage(
      {Key? key, required this.title, this.id, required this.navigatorKey})
      : super(key: key);

  final String title;
  final String? id;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
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
            Text(
              'Id from Route: ${widget.id}',
            ),
          ],
        ),
      ),
    );
  }
}

class PostDetails {
  final String? id;
  final String? title;

  PostDetails({this.id, this.title});
}
