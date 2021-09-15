import 'package:flutter/material.dart';
import 'package:meme/main.dart';
import 'package:meme/resources/repository.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage(
      {Key? key, required this.title, required this.navigatorKey})
      : super(key: key);
  final String title;
  final GlobalKey<NavigatorState> navigatorKey;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final debugClass = '_RegisterPageState';
  final _repository = Repository();
  final _registerFormKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  bool _obscurePassword = true;
  bool _obscurePasswordConfirm = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _passwordConfirmController.dispose();
    super.dispose();
  }

  _doRegister() {
    if (_registerFormKey.currentState!.validate()) {
      /// TODO Register
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
                    key: _registerFormKey,
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

                            /// Check if password is null, empty
                            validator: (password) {
                              if (password == null || password.isEmpty) {
                                return 'Please enter password';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Password',

                              /// Password visibility toggle
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

                          /// Confirm Password TextFormField
                          TextFormField(
                            keyboardType: TextInputType.visiblePassword,
                            validator: (passwordConfirm) {
                              /// Check if Confirm Password is null, empty
                              if (passwordConfirm == null ||
                                  passwordConfirm.isEmpty) {
                                return 'Please enter password';
                              }

                              /// Check if password matches
                              if (passwordConfirm !=
                                  _passwordController.value.text) {
                                return 'Password did not match';
                              }
                              return null;
                            },
                            decoration: InputDecoration(
                              hintText: 'Confirm Password',

                              /// Password visibility toggle
                              suffixIcon: IconButton(
                                icon: Icon(
                                  _obscurePasswordConfirm
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _obscurePasswordConfirm =
                                        !_obscurePasswordConfirm;
                                  });
                                },
                              ),
                            ),
                            obscureText: _obscurePasswordConfirm,
                            controller: _passwordConfirmController,
                          ),
                        ],
                      ),
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

                        /// TODO Register
                        _doRegister();
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
