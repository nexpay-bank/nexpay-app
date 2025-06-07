import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:nexpay/core/themes/theme_extensions.dart';
import 'package:nexpay/shared/widgets/title_widget.dart';

class QuickSendWidget extends StatelessWidget {
  const QuickSendWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> users = [
      {"name": "Johan", "avatar": "https://i.pravatar.cc/150?img=1"},
      {"name": "Roger", "avatar": "https://i.pravatar.cc/150?img=2"},
      {"name": "Steven", "avatar": "https://i.pravatar.cc/150?img=3"},
      {"name": "Luna", "avatar": "https://i.pravatar.cc/150?img=4"},
      {"name": "Kai", "avatar": "https://i.pravatar.cc/150?img=5"},
      {"name": "Cenat", "avatar": "https://i.pravatar.cc/150?img=6"},
      {"name": "Furina", "avatar": "https://i.pravatar.cc/150?img=7"},
      {"name": "Miya", "avatar": "https://i.pravatar.cc/150?img=8"},
      {"name": "Alucard", "avatar": "https://i.pravatar.cc/150?img=9"},
      {"name": "Sasuke", "avatar": "https://i.pravatar.cc/150?img=10"},
      {"name": "Hanabi", "avatar": "https://i.pravatar.cc/150?img=11"},
    ];
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 16,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: TitleWidget(title: "Quick Send"),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: context.colors.onBackground.withAlpha(20),
                        borderRadius: BorderRadius.circular(90),
                      ),
                      child: DottedBorder(
                        options: CircularDottedBorderOptions(
                          dashPattern: [10, 5],
                          strokeWidth: 1,
                          color: context.colors.onBackground,
                          padding: EdgeInsets.all(12),
                        ),
                        child: Icon(Icons.add, color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      "Add",
                      style: TextStyle(fontSize: 12, color: Colors.white),
                    ),
                  ],
                ),
              ),
              ...users.map((user) {
                return Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage: NetworkImage(user["avatar"]!),
                        radius: 24,
                      ),
                      const SizedBox(height: 4),
                      Text(user["name"]!, style: const TextStyle(fontSize: 12)),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
