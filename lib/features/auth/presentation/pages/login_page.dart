import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nexpay/features/auth/presentation/pages/register_page.dart';
import 'package:nexpay/features/navigation/pages/navigation_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late bool _isChecked;
  late bool _obscureText;
  late bool _first;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isChecked = false;
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _obscureText = true;
    _first = true;
  }

  @override
  void dispose() {
    super.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _handleLogin() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;
      context.read<AuthCubit>().login(username: username, password: password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (state is AuthLoading) {
          } else if (state is AuthSuccess) {
            Fluttertoast.showToast(
              msg: "Login Success",
              toastLength: Toast.LENGTH_SHORT,
              gravity: ToastGravity.BOTTOM,
            );

            Navigator.pushReplacement(
              context,
              CupertinoPageRoute(builder: (context) => const NavigationPage()),
            );
          } else if (state is AuthFailure && state is! AuthLoading) {
            Fluttertoast.showToast(
              msg: "Login Failed",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.BOTTOM,
              backgroundColor: Colors.red,
              textColor: Colors.white,
            );
            showCupertinoDialog(
              context: context,
              builder: (context) => CupertinoAlertDialog(
                title: const Text("Failed"),
                content: Text(state.message),
                actions: [
                  CupertinoDialogAction(
                    child: const Text("Retry"),
                    onPressed: () {
                      Navigator.pop(context); // tutup dialog
                    },
                  ),
                ],
              ),
            );
          } else {
            // initial atau fallback
          }
        });
      },
      child: BlocBuilder<AuthCubit, AuthState>(
        builder: (context, state) {
          return Scaffold(
            body: Stack(
              children: [
                Positioned.fill(
                  child: Expanded(
                    child: Image.asset("assets/images/auth_background.png"),
                  ),
                ),
                Column(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 64),
                      child: Text(
                        "LOGIN TO \n YOUR ACCOUNT",
                        textAlign: TextAlign.center,
                        style: context.textTheme.displayLarge,
                      ),
                    ),
                    Expanded(
                      child: ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 64, sigmaY: 64),
                          child: Container(
                            decoration: BoxDecoration(
                              border: Border(
                                top: BorderSide(
                                  color: context.colors.onBackground.withValues(
                                    alpha: 0.2,
                                  ),
                                ),
                              ),
                            ),
                            padding: EdgeInsets.all(16),
                            child: Column(
                              spacing: 16,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 16,
                                  ),
                                  child: Text('Enter your login information'),
                                ),
                                Form(
                                  key: _formKey,
                                  child: Column(
                                    spacing: 16,
                                    children: [
                                      TextFormField(
                                        controller: _usernameController,
                                        validator: (value) {
                                          if (RegExp(
                                            r'^[a-zA-Z]+$',
                                          ).hasMatch(value!)) {
                                            return null;
                                          }
                                          return 'Username not valid';
                                        },
                                        decoration: const InputDecoration(
                                          prefixIcon: Icon(Iconsax.user_copy),
                                          label: Text("Username"),
                                        ),
                                      ),
                                      SizedBox(height: 8),
                                      TextFormField(
                                        obscureText: _obscureText,
                                        controller: _passwordController,
                                        validator: (value) {
                                          if (value == '') {
                                            return 'Password cannot empty';
                                          }
                                          return null;
                                        },
                                        decoration: InputDecoration(
                                          prefixIcon: const Icon(
                                            Iconsax.lock_copy,
                                          ),
                                          suffixIcon: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _obscureText = !_obscureText;
                                              });
                                            },
                                            splashColor: Colors.transparent,
                                            // borderRadius: kMainBorderRadius,
                                            child: Icon(
                                              _obscureText
                                                  ? Iconsax.eye_copy
                                                  : Iconsax.eye_slash_copy,
                                            ),
                                          ),
                                          label: const Text("Password"),
                                        ),
                                      ),
                                      Row(
                                        children: [
                                          Checkbox(
                                            value: _isChecked,
                                            onChanged: (value) {
                                              setState(() {
                                                _isChecked = !_isChecked;
                                              });
                                            },
                                          ),
                                          const Text('Keep me for a week'),
                                          const Spacer(),
                                          // TextButton(
                                          //   onPressed: () {},
                                          //   child: const Text('Forgot Password?'),
                                          // ),
                                        ],
                                      ),
                                      SizedBox(
                                        width: double.infinity,
                                        child: ElevatedButton(
                                          onPressed: _handleLogin,
                                          child: state is AuthLoading
                                              ? Text('Please wait')
                                              : Text('Login'),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Flexible(
                                            child: Divider(
                                              indent: 50,
                                              endIndent: 5,
                                              color: Colors.grey,
                                              thickness: 0.5,
                                            ),
                                          ),
                                          Text(
                                            'Or Create New Account',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(color: Colors.grey),
                                          ),
                                          const Flexible(
                                            child: Divider(
                                              indent: 5,
                                              endIndent: 50,
                                              color: Colors.grey,
                                              thickness: 0.5,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          const Text(
                                            'Didn\'t have an Account?',
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.pushReplacement(
                                                context,
                                                CupertinoPageRoute(
                                                  builder: (context) =>
                                                      RegisterPage(),
                                                ),
                                              );
                                            },
                                            child: const Text('Register'),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                state is AuthLoading
                    ? Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: context.colors.background.withValues(
                              alpha: 0.5,
                            ),
                          ),
                          child: Center(child: CircularProgressIndicator()),
                        ),
                      )
                    : Container(),
              ],
            ),
          );
        },
      ),
    );
  }
}
