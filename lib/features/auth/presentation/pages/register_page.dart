import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/routes/route_name.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:nexpay/features/auth/presentation/pages/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late TextEditingController _emailController;
  late TextEditingController _passwordController;
  late TextEditingController _usernameController;
  late bool _isChecked;
  late bool _obscureText;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _isChecked = false;
    _emailController = TextEditingController();
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _obscureText = true;
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _usernameController.dispose();
    _passwordController.dispose();
  }

  void _handleRegister() async {
    if (_formKey.currentState!.validate()) {
      final username = _usernameController.text;
      final password = _passwordController.text;

      try {
        context.read<AuthCubit>().register(
          username: username,
          password: password,
        );

        Fluttertoast.showToast(
          msg: "Register Success",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
        );

        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Register Success"),
            content: const Text("Please login with your new account!"),
            actions: [
              CupertinoDialogAction(
                child: const Text("Login"),
                onPressed: () {
                  Navigator.pop(context); // tutup dialog
                  // Navigasi ke halaman login
                  Navigator.pushReplacement(
                    context,
                    CupertinoPageRoute(builder: (context) => const LoginPage()),
                  );
                },
              ),
            ],
          ),
        );
      } catch (e) {
        Fluttertoast.showToast(
          msg: "Register failed",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
        );

        showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoAlertDialog(
            title: const Text("Gagal"),
            content: Text("Registrasi gagal: ${e.toString()}"),
            actions: [
              CupertinoDialogAction(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.pop(context); // tutup dialog
                },
              ),
            ],
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Text('Enter your information'),
                          ),
                          Form(
                            key: _formKey,
                            child: Column(
                              spacing: 16,
                              children: [
                                TextFormField(
                                  controller: _usernameController,
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Name cannot empty';
                                    }
                                    if (!RegExp(
                                      r'^[a-zA-Z]+$',
                                    ).hasMatch(value)) {
                                      return 'Name cannot empty symbol or number';
                                    }
                                    return null;
                                  },

                                  decoration: const InputDecoration(
                                    prefixIcon: Icon(Iconsax.user_copy),
                                    label: Text("username"),
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
                                    prefixIcon: const Icon(Iconsax.lock_copy),
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
                                    const Text(
                                      'I agree to the terms and conditions',
                                    ),
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
                                    onPressed: _handleRegister,
                                    child: const Text('Register'),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
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
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Text('Already have an Account?'),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushReplacement(
                                          context,
                                          CupertinoPageRoute(
                                            builder: (context) => LoginPage(),
                                          ),
                                        );
                                      },
                                      child: const Text('Login'),
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
        ],
      ),
    );
  }
}
