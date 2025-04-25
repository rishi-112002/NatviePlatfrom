import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PlatformText extends StatelessWidget {
  final String title;
  final bool isIOS;

  const PlatformText({super.key, required this.title, required this.isIOS});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style:
          isIOS
              ? const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                color: CupertinoColors.label,
              )
              : Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Theme.of(context).colorScheme.onSurface,
                  ) ??
                  const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.0,
                    color: Colors.black,
                  ),
    );
  }
}
