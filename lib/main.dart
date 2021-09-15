import 'dart:async';

import 'package:flutter/material.dart';
import 'package:meme/home.dart';
import 'package:meme/login.dart';
import 'package:meme/post.dart';
import 'package:meme/profile.dart';
import 'package:meme/register.dart';
import 'package:meme/resources/repository.dart';
import 'package:meme/settings.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final _mainNavigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // home: const NavigatorPage(title: 'Flutter Demo Home Page'),
      navigatorKey: _mainNavigatorKey,
      onGenerateRoute: (RouteSettings settings) {
        WidgetBuilder builder;
        switch (settings.name) {
          case Nemo.home:
            builder = (BuildContext context) => NavigatorPage(
                  title: 'Home',
                  route: Nemo.home,
                  navigatorKey: _mainNavigatorKey,
                  showDrawer: true,
                );
            break;
          case Nemo.post:
            builder = (BuildContext context) => NavigatorPage(
                  title: 'Post',
                  route: Nemo.post,
                  navigatorKey: _mainNavigatorKey,
                  showDrawer: true,
                  args: settings.arguments,
                );
            break;
          case Nemo.profile:
            builder = (BuildContext context) => NavigatorPage(
                title: 'Profile',
                route: Nemo.profile,
                navigatorKey: _mainNavigatorKey,
                showDrawer: true);
            break;
          case Nemo.settings:
            builder = (BuildContext context) => NavigatorPage(
                title: 'Settings',
                route: Nemo.settings,
                navigatorKey: _mainNavigatorKey,
                showDrawer: true);
            break;
          case Nemo.login:
            builder = (BuildContext context) => NavigatorPage(
                title: 'Login',
                route: Nemo.login,
                navigatorKey: _mainNavigatorKey,
                showDrawer: false);
            break;
          case Nemo.register:
            builder = (BuildContext context) => NavigatorPage(
                title: 'Register',
                route: Nemo.register,
                navigatorKey: _mainNavigatorKey,
                showDrawer: false);
            break;
          default:
            builder = (BuildContext context) => NavigatorPage(
                title: 'Unknown',
                route: '404',
                navigatorKey: _mainNavigatorKey,
                showDrawer: false);
            break;
        }
        return MaterialPageRoute(
          builder: builder,
          settings: settings,
        );
      },

      /// Named Routes with arguments require  RouteSettings
      /// See implementation on `onGenerateRoute: (RouteSettings settings)`
      // routes: {
      //   /// [title] updates the title on the main AppBar
      //   /// [route] NavigatorPage Router depends on route defined on this parameter
      //   /// [showDrawer] show/hide main AppBar drawer
      //   Nemo.home: (context) => NavigatorPage(
      //         title: 'Home',
      //         route: Nemo.home,
      //         navigatorKey: _mainNavigatorKey,
      //         showDrawer: true,
      //       ),
      //   Nemo.post: (context) => NavigatorPage(
      //       title: 'Post',
      //       route: Nemo.post,
      //       navigatorKey: _mainNavigatorKey,
      //       showDrawer: true),
      //   Nemo.profile: (context) => NavigatorPage(
      //       title: 'Profile',
      //       route: Nemo.profile,
      //       navigatorKey: _mainNavigatorKey,
      //       showDrawer: true),
      //   Nemo.settings: (context) => NavigatorPage(
      //       title: 'Settings',
      //       route: Nemo.settings,
      //       navigatorKey: _mainNavigatorKey,
      //       showDrawer: true),
      //   Nemo.login: (context) => NavigatorPage(
      //       title: 'Login',
      //       route: Nemo.login,
      //       navigatorKey: _mainNavigatorKey,
      //       showDrawer: false),
      //   Nemo.register: (context) => NavigatorPage(
      //       title: 'Register',
      //       route: Nemo.register,
      //       navigatorKey: _mainNavigatorKey,
      //       showDrawer: false),
      // },
    );
  }
}

class NavigatorPage extends StatefulWidget {
  const NavigatorPage(
      {Key? key,
      required this.title,
      required this.route,
      required this.navigatorKey,
      required this.showDrawer,
      this.args})
      : super(key: key);

  final String title;
  final String route;
  final bool showDrawer;
  final Object? args;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<NavigatorPage> createState() => _NavigatorPageState();
}

class _NavigatorPageState extends State<NavigatorPage> {
  // final _navigatorKey = GlobalKey<NavigatorState>();
  int drawerDelay = 300;
  bool? authState;
  final _repository = Repository();

  @override
  void initState() {
    super.initState();

    _repository.getAuthState().then((value) {
      setState(() {
        authState = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      drawer: widget.showDrawer
          ? Drawer(
              /// TODO return null to hide Drawer if in Login/Registration page
              // Add a ListView to the drawer. This ensures the user can scroll
              // through the options in the drawer if there isn't enough vertical
              // space to fit everything.
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: drawer(authState ?? false),
              ),
            )
          : null,
      body: Navigator(
        // key: _navigatorKey,

        /// initialRoute needs to be set to '/'
        onGenerateRoute: (RouteSettings settings) {
          WidgetBuilder builder;
          // Manage your route names here
          // switch (settings.name) {
          switch (widget.route) {

            /// Default page displayed on Home Screen
            case Nemo.home:
              builder = (BuildContext context) => _homePage();
              break;
            case Nemo.post:

              /// Fetch arguments
              PostDetails? args;
              if (widget.args != null) {
                debugPrint('arguments has data');
                args = widget.args as PostDetails;
              } else {
                debugPrint('arguments is empty');
              }
              debugPrint('PostDetails id: ${args?.id} title: ${args?.title}');
              builder = (BuildContext context) => _postPage(postId: args?.id);
              break;
            case Nemo.profile:
              builder = (BuildContext context) => _profilePage();
              break;
            case Nemo.settings:
              builder = (BuildContext context) => _settingsPage();
              break;
            case Nemo.login:
              builder = (BuildContext context) => _loginPage();
              break;
            case Nemo.register:
              builder = (BuildContext context) => _registerPage();
              break;
            default:
              builder = (BuildContext context) => const UnknownPage();
          }
          return MaterialPageRoute(
            builder: builder,
            settings: settings,
          );
        },
      ),
    );
  }

  Widget _homePage() =>
      HomePage(title: 'Home', navigatorKey: widget.navigatorKey);
  Widget _postPage({String? postId}) =>
      PostPage(title: 'Post', navigatorKey: widget.navigatorKey, id: postId);
  Widget _profilePage() =>
      ProfilePage(title: 'Profile', navigatorKey: widget.navigatorKey);
  Widget _settingsPage() =>
      SettingsPage(title: 'Settings', navigatorKey: widget.navigatorKey);
  Widget _loginPage() =>
      LoginPage(title: 'Login', navigatorKey: widget.navigatorKey);
  Widget _registerPage() =>
      RegisterPage(title: 'Register', navigatorKey: widget.navigatorKey);

  /// Display this Drawer if user is Authenticated
  List<Widget> drawer(bool isAuthenticated) {
    if (isAuthenticated) {
      return <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Home'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);

            /// [drawerDelay] gives time to animate the closing of the Drawer
            Timer(Duration(milliseconds: drawerDelay), () async {
              widget.navigatorKey.currentState!
                  .pushNamedAndRemoveUntil(Nemo.home, (Route route) => false);
            });
          },
        ),
        ListTile(
          title: const Text('Profile'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);

            Timer(Duration(milliseconds: drawerDelay), () async {
              widget.navigatorKey.currentState!.pushNamed(Nemo.profile);
            });
          },
        ),
        ListTile(
          title: const Text('Settings'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);

            Timer(Duration(milliseconds: drawerDelay), () async {
              widget.navigatorKey.currentState!.pushNamed(Nemo.settings);
            });
          },
        ),
        ListTile(
          title: const Text('Logout'),
          onTap: () {
            /// TODO Logout function
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);

            /// update authState
            setState(() {
              authState = false;
            });

            /// Update auth state on SharedPreferences
            _repository.setAuthState(false);
            Timer(Duration(milliseconds: drawerDelay), () async {
              widget.navigatorKey.currentState!.pushNamedAndRemoveUntil(Nemo.login, (Route route) => false);
            });
          },
        ),
      ];
    } else {
      return <Widget>[
        const DrawerHeader(
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
          child: Text('Drawer Header'),
        ),
        ListTile(
          title: const Text('Login'),
          onTap: () {
            // Update the state of the app
            // ...
            // Then close the drawer
            Navigator.pop(context);

            /// [drawerDelay] gives time to animate the closing of the Drawer
            Timer(Duration(milliseconds: drawerDelay), () async {
              widget.navigatorKey.currentState!.pushNamed(Nemo.login);
            });
          },
        ),
      ];
    }
  }
}

class Nemo {
  static const home = '/';
  static const login = '/login';
  static const register = '/register';
  static const post = '/post';
  static const profile = '/profile';
  static const settings = '/settings';
}

/// Constant values for UI elements
class Constants {
  static const String webVersion = 'web-0.1.9-dev';
  static const double paddingSmall = 8.0;
  static const double paddingNormal = 16.0;

  static const double heightNormal = 64.0;

  static const double heightThreadCard = 72.0;
  static const double heightButtonNormal = 42.0;

  static const double widthButtonNormal = 160.0;
}

class SharedPrefKey {
  static const String email = 'email';
  static const String password = 'password';
  static const String authState = 'authState';
}

class Validator {
  /// Validates email address String
  validateEmail(String email) {
    /// Only allow email.com domain
    // return RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[email]+\.[a-zA-Z]+").hasMatch(email);
    /// Allow any email domain
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }

  /// Validate password String
  validatePassword(String password) {
    /// TODO password validator
    return true;
  }
}

class UnknownPage extends StatefulWidget {
  const UnknownPage({Key? key}) : super(key: key);

  @override
  State<UnknownPage> createState() => _UnknownPageState();
}

class _UnknownPageState extends State<UnknownPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const <Widget>[
            Text(
              '404',
            ),
          ],
        ),
      ),
    );
  }
}
