import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_setup/utils/platform_utils.dart';
import 'package:native_setup/widgets/platform_text.dart';

class PlatformRadioGroup extends StatelessWidget {
  final String title;
  final int value;
  final List<String> labels;
  final ValueChanged<int?> onChanged;

  const PlatformRadioGroup({
    super.key,
    required this.title,
    required this.value,
    required this.labels,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    // Ensure value is within bounds
    final int currentValue = (value >= 0 && value < labels.length) ? value : 0;

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PlatformText(title: title, isIOS: isIOS),
          const SizedBox(height: 8.0),
          Column(
            children: List<Widget>.generate(labels.length, (int index) {
              return isIOS
                  ? CupertinoFormRow(
                    prefix: Text(labels[index]),
                    child: CupertinoRadio<int>(
                      value: index,
                      groupValue: currentValue,
                      onChanged: onChanged,
                    ),
                  )
                  : RadioListTile<int>(
                    title: Text(labels[index]),
                    value: index,
                    groupValue: currentValue,
                    onChanged: onChanged,
                  );
            }),
          ),
        ],
      ),
    );
  }
}
