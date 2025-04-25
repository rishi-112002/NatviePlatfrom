import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

class PlatformTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;

  const PlatformTextField({
    super.key,
    required this.controller,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child:
          isIOS
              ? CupertinoTextField(
                controller: controller,
                placeholder: placeholder,
                clearButtonMode: OverlayVisibilityMode.editing,
                padding: const EdgeInsets.all(12.0),
              )
              : TextField(
                controller: controller,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(),
                  labelText: placeholder,
                ),
              ),
    );
  }
}
