import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:isar/isar.dart';
import 'package:nexpay/core/routes/route_name.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/features/auth/presentation/pages/login_page.dart';
import 'package:nexpay/features/home/presentation/cubit/user_cubit.dart';
import 'package:nexpay/features/onboarding/presentation/pages/onboarding_page.dart';
import 'package:nexpay/injection_container.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return SafeArea(
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Stack(
                    children: const [
                      Center(child: TitleWidget(title: 'My Profile')),
                    ],
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 0.5,
                  color: colors.onBackground.withOpacity(0.3),
                ),
                const SizedBox(height: 16),

                Center(
                  child: Stack(
                    children: [
                      BlocBuilder<UserCubit, UserState>(
                        builder: (context, state) {
                          if (state is UserSuccess) {
                            return CircleAvatar(
                              radius: 120,
                              backgroundImage: NetworkImage(
                                state.user.avatarUrl,
                              ),
                            );
                          } else {
                            return const CircleAvatar(
                              radius: 120,
                              backgroundImage: NetworkImage(
                                'https://static1.cbrimages.com/wordpress/wp-content/uploads/2022/08/Lycoris-Recoil-Chisato-camera-flashback.jpeg',
                              ),
                            );
                          }
                        },
                      ),
                      Positioned(
                        right: 18,
                        bottom: 18,
                        child: GestureDetector(
                          onTap: () async {
                            final picker = ImagePicker();
                            final image = await picker.pickImage(
                              source: ImageSource.gallery,
                            );
                            if (image != null) {
                              context.read<UserCubit>().updatePhoto(
                                File(image.path),
                              );
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: context.colors.onBackground,
                              borderRadius: BorderRadius.circular(120),
                            ),
                            child: Icon(
                              Iconsax.trash_copy,
                              color: context.colors.background,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),

                // Settings Section
                _sectionTitle('Settings'),
                // _settingTile(
                //   Iconsax.global_copy,
                //   'Language',
                //   'English (US)',
                //   true,
                // ),
                _settingTile(
                  Iconsax.notification_copy,
                  'Notification',
                  '',
                  true,
                ),
                _switchTile(Iconsax.moon_copy, 'Dark Mode', false),

                Divider(color: colors.onBackground.withValues(alpha: 0.3)),

                // Security Section
                _sectionTitle('Security'),
                _settingTile(
                  Iconsax.password_check_copy,
                  'Change PIN Number',
                  '',
                  true,
                ),
                _settingTile(Iconsax.lock_1_copy, 'Change Password', '', true),
                _settingTile(
                  Iconsax.security_user_copy,
                  'Two Factor Authentication',
                  '',
                  true,
                ),
                _switchTile(Iconsax.finger_scan, 'Login Fingerprint', true),
                Divider(color: colors.onBackground.withValues(alpha: 0.3)),
                SizedBox(height: 32),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text("Delete Account"),
                                content: Text("Are you sure?"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      context.read<UserCubit>().delete();
                                      Navigator.pop(context);
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(
                              colors.background,
                            ),
                          ),
                          child: Text("Delete Account"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            showCupertinoDialog(
                              context: context,
                              builder: (context) => CupertinoAlertDialog(
                                title: const Text("Log Out"),
                                content: Text("Are you sure?"),
                                actions: [
                                  CupertinoDialogAction(
                                    child: const Text("OK"),
                                    onPressed: () {
                                      context.read<UserCubit>().logout();
                                      Navigator.pop(context);
                                      Navigator.pushReplacementNamed(
                                        context,
                                        RouteName.login,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            );
                          },
                          style: ButtonStyle(
                            foregroundColor: WidgetStateProperty.all(
                              colors.background,
                            ),
                          ),
                          child: Text("Log Out"),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 64),
              ],
            ),
            BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                if (state is UserLogout) {
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.pushReplacement(
                      context,
                      CupertinoPageRoute(
                        builder: (context) => const OnboardingPage(),
                      ),
                    );
                  });
                }
                return state is UserLoading
                    ? Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            color: colors.background.withValues(alpha: 0.4),
                          ),
                          child: Center(child: CupertinoActivityIndicator()),
                        ),
                      )
                    : Container();
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Text(
        title,
        style: const TextStyle(fontSize: 14, color: Colors.grey),
      ),
    );
  }

  Widget _settingTile(
    IconData icon,
    String title,
    String value,
    bool hasArrow,
  ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (value.isNotEmpty)
            Text(value, style: const TextStyle(color: Colors.grey)),
          if (hasArrow)
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 16,
              color: Colors.grey,
            ),
        ],
      ),
    );
  }

  Widget _switchTile(IconData icon, String title, bool value) {
    return SwitchListTile(
      secondary: Icon(icon),
      title: Text(title),
      value: value,
      onChanged: (_) {},
      activeColor: Colors.yellow,
    );
  }
}
