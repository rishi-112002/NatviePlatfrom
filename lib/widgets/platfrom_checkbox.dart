import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_setup/utils/platform_utils.dart';
import 'package:native_setup/widgets/platform_text.dart';

class PlatformCheckboxGroup extends StatelessWidget {
  final String title;
  final List<bool> values;
  final List<String> labels;
  final Function(int, bool?) onChanged;

  const PlatformCheckboxGroup({
    super.key,
    required this.title,
    required this.values,
    required this.labels,
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
          isIOS ? _buildCupertinoCheckboxes() : _buildMaterialCheckboxes(),
        ],
      ),
    );
  }

  Widget _buildCupertinoCheckboxes() {
    return Column(
      children: List.generate(
        values.length,
        (index) => CupertinoFormRow(
          prefix: Text(labels[index]),
          child: CupertinoCheckbox(
            value: values[index],
            onChanged: (value) => onChanged(index, value),
          ),
        ),
      ),
    );
  }

  Widget _buildMaterialCheckboxes() {
    return Column(
      children: List.generate(
        values.length,
        (index) => CheckboxListTile(
          title: Text(labels[index]),
          value: values[index],
          onChanged: (value) => onChanged(index, value),
        ),
      ),
    );
  }
}
