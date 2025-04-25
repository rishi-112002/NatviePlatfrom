import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

class PlatformButton extends StatelessWidget {
  final String title;
  final String label;
  final VoidCallback onPressed;

  const PlatformButton({
    super.key,
    required this.title,
    required this.label,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style:
                isIOS
                    ? const TextStyle(fontWeight: FontWeight.bold)
                    : Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8.0),
          isIOS
              ? CupertinoButton.filled(onPressed: onPressed, child: Text(label))
              : ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  minimumSize: const Size(double.infinity, 48.0),
                ),
                onPressed: onPressed,
                child: Text(label),
              ),
        ],
      ),
    );
  }
}
