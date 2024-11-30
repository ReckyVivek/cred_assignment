import 'package:flutter/material.dart';

class PageTitle extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const PageTitle({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                ),
              ),
            ),
            const Icon(
              Icons.keyboard_arrow_up,
              color: Colors.white54,
            ),
          ],
        ),
      ),
    );
  }
}
