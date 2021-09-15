import 'package:flutter/material.dart';
import 'package:meme/main.dart';
import 'package:meme/resources/repository.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key, required this.title, required this.navigatorKey})
      : super(key: key);
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final debugClass = '_LoginPageState';
  final _repository = Repository();
  final _loginFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  _doLogin() {
    if (_loginFormKey.currentState!.validate()) {
      /// TODO Login
      _repository.setAuthState(true);
      widget.navigatorKey.currentState!.pushNamed(Nemo.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text(widget.title),
      // ),
      body: GestureDetector(
        /// Hide keyboard when on tapping the surface
        behavior: HitTestBehavior.translucent,
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          padding: const EdgeInsets.all(Constants.paddingNormal),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(Constants.paddingNormal),
                  child: Form(
                    key: _loginFormKey,
                    child: AutofillGroup(
                      child: Column(
                        children: <Widget>[
                          /// Email TextFormField
                          TextFormField(
                            autofillHints: const [AutofillHints.email],
                            keyboardType: TextInputType.emailAddress,

                            /// Check if email is null, empty, valid
                            validator: (email) {
                              if (email == null ||
                                  email.isEmpty ||
                                  !Validator().validateEmail(email)) {
                                return 'Please enter valid email';
                              }
                              return null;
                            },
                            decoration: const InputDecoration(
                                hintText: 'Email Address'),
                            controller: _emailController,
                          ),

                          /// Password TextFormField
                          TextFormField(
                            autofillHints: const [AutofillHints.password],
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.go,

                            /// TODO Login
                            // onFieldSubmitted: (value) => _doLogin(),

                            /// Check if password is null, empty
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePassword
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePassword = !_obscurePassword;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePassword,
                            controller: _passwordController,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                /// Login Button
                Padding(
                  padding: const EdgeInsets.all(Constants.paddingNormal),
                  child: SizedBox(
                    width: Constants.widthButtonNormal,
                    height: Constants.heightButtonNormal,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();

                        /// TODO login
                        _doLogin();
                      },
                      child: const Text('Login'),
                    ),
                  ),
                ),

                /// Register Button
                Padding(
                  padding: const EdgeInsets.all(Constants.paddingNormal),
                  child: SizedBox(
                    width: Constants.widthButtonNormal,
                    height: Constants.heightButtonNormal,
                    child: ElevatedButton(
                      onPressed: () {
                        FocusScope.of(context).unfocus();
                        // Navigate to Registration Screen
                        widget.navigatorKey.currentState!
                            .pushNamed(Nemo.register);
                      },
                      child: const Text('Register'),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
