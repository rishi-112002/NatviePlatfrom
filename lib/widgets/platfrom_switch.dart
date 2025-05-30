import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:native_setup/widgets/platform_text.dart';
import '../utils/platform_utils.dart';

class PlatformSwitch extends StatelessWidget {
  final String title;
  final String label;
  final bool value;
  final ValueChanged<bool> onChanged;

  const PlatformSwitch({
    super.key,
    required this.title,
    required this.label,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlatformText(title: title, isIOS: isIOS),
          const SizedBox(height: 8.0),
          isIOS
              ? CupertinoFormRow(
                prefix: Text(label),
                child: CupertinoSwitch(value: value, onChanged: onChanged),
              )
              : SwitchListTile(
                title: Text(label),
                value: value,
                onChanged: onChanged,
              ),
        ],
      ),
    );
  }
}
