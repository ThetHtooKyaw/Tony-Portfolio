import 'package:flutter/material.dart';
import 'package:tony_portfolio/core/theme/app_color.dart';

class ListWidget extends StatelessWidget {
  final String title;
  final List<String> items;
  const ListWidget({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontFamily: 'Oswald',
            color: AppColor.accent,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: items.map((item) {
            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CircleAvatar(radius: 4, backgroundColor: AppColor.accent),
                  const SizedBox(width: 10),

                  Expanded(
                    child: Text(
                      item,
                      style: const TextStyle(
                        fontFamily: 'Open Sans',
                        color: AppColor.light,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
