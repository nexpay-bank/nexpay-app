import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colors = context.colors;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Stack(
              children: const [Center(child: TitleWidget(title: 'My Profile'))],
            ),
          ),
          Divider(
            height: 1,
            thickness: 0.5,
            color: colors.onBackground.withOpacity(0.3),
          ),
          const SizedBox(height: 16),

          // Profile Card
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.black87,
                borderRadius: BorderRadius.circular(16),
                gradient: const LinearGradient(
                  colors: [Colors.black87, Colors.yellow],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                children: [
                  const CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(
                      'https://i.pravatar.cc/150?img=3',
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Michael John',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                        Text(
                          'michaeljohn@gmail.com',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ),
                  Icon(Iconsax.edit_copy, color: context.colors.onBackground),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Settings Section
          _sectionTitle('Settings'),
          _settingTile(Iconsax.global_copy, 'Language', 'English (US)', true),
          _settingTile(Iconsax.notification_copy, 'Notification', '', true),
          _switchTile(Iconsax.moon_copy, 'Dark Mode', false),

          const Divider(height: 32),

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
        ],
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
