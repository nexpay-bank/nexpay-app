import 'package:flutter/material.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';

class CreditCardWidget extends StatelessWidget {
  const CreditCardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: context.colors.primary,
        borderRadius: BorderRadius.all(Radius.circular(24)),
      ),
      padding: EdgeInsets.all(16),
      width: MediaQuery.of(context).size.width - 16,
      height: (MediaQuery.of(context).size.width - 16) * 9 / 16,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Your Balance',
            style: Theme.of(
              context,
            ).textTheme.bodyLarge!.copyWith(color: context.colors.background),
          ),
          Text(
            '\$31,286.00',
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
              color: context.colors.background,
              fontSize: 64,
            ),
          ),
          Spacer(),
          Stack(
            alignment: Alignment.center,
            children: [
              Expanded(
                child: Container(
                  width: MediaQuery.of(context).size.width - 16,
                  height: 30,
                  decoration: BoxDecoration(
                    color: context.colors.background,
                    borderRadius: BorderRadius.circular(90),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _GlassButton(
                    icon: Icons.arrow_upward,
                    label: 'Transfer',
                    onTap: () {},
                  ),
                  _GlassButton(
                    icon: Icons.arrow_downward,
                    label: 'Request',
                    onTap: () {},
                  ),
                  _GlassIconButton(icon: Iconsax.menu_copy, onTap: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GlassButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _GlassButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(32),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          decoration: BoxDecoration(
            color: context.colors.background,
            borderRadius: BorderRadius.circular(32),
          ),
          child: Row(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: context.colors.primary,
                  borderRadius: BorderRadius.all(Radius.circular(32)),
                ),
                child: Transform.rotate(
                  angle: -3.14 / 4 * 3,
                  child: Icon(icon, color: Colors.black),
                ),
              ),
              const SizedBox(width: 6),
              Text(
                label,
                style: TextStyle(
                  color: context.colors.onBackground,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _GlassIconButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(32),
      child: Container(
        padding: EdgeInsets.all(6),
        width: 48,
        height: 48,
        decoration: BoxDecoration(
          color: context.colors.background,
          borderRadius: BorderRadius.circular(32),
        ),
        child: Container(
          // padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(90),
            color: context.colors.onBackground.withValues(alpha: 0.3),
          ),
          child: Icon(icon, color: Colors.white, size: 20),
        ),
      ),
    );
  }
}
