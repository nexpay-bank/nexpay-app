import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class LimitWidget extends StatelessWidget {
  const LimitWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title & Edit Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const TitleWidget(title: 'Limit Settings'),
            ElevatedButton.icon(
              onPressed: () {},
              icon: const Icon(Iconsax.edit_copy),
              label: const Text("Edit"),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 6,
                ),
                foregroundColor: context.colors.onBackground,
                shape: StadiumBorder(),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),

        // Transaction & Withdraw Limit
        Row(
          children: [
            Expanded(
              child: _limitBox("Transaction Limit", "\$5,000.00", context),
            ),
            const SizedBox(width: 12),
            Expanded(child: _limitBox("Withdraw Limit", "\$2,500.00", context)),
          ],
        ),
        const SizedBox(height: 24),

        // Toggles
        _switchTile("Card Status", true),
        _switchTile("Foreign Transactions", false),
        _switchTile("Online Transactions", true),
      ],
    );
  }

  Widget _limitBox(String label, String value, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.colors.onBackground.withValues(alpha: 0.1),
        ),
        borderRadius: BorderRadius.circular(12),
        color: context.colors.surface,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: context.textTheme.labelSmall),
          const SizedBox(height: 4),
          Text(value, style: context.textTheme.bodyLarge),
        ],
      ),
    );
  }

  Widget _switchTile(String title, bool value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Text(
            value ? "Active" : "Inactive",
            style: TextStyle(
              color: value ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 8),
          Switch(value: value, onChanged: (_) {}, activeColor: Colors.yellow),
        ],
      ),
    );
  }
}
