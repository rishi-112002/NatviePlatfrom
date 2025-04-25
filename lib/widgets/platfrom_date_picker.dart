import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

class PlatformDatePicker extends StatelessWidget {
  final DateTime selectedDate;
  final VoidCallback onPressed;
  final Function(DateTime) onDateChanged;

  const PlatformDatePicker({
    super.key,
    required this.selectedDate,
    required this.onPressed,
    required this.onDateChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 8.0),
      width: double.infinity,
      child:
          isIOS
              ? CupertinoButton(
                padding: const EdgeInsets.symmetric(
                  vertical: 12.0,
                  horizontal: 16.0,
                ),
                color: CupertinoColors.systemGrey5,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                      style: const TextStyle(color: CupertinoColors.label),
                    ),
                    const Icon(
                      CupertinoIcons.calendar,
                      color: CupertinoColors.label,
                    ),
                  ],
                ),
                onPressed: () => _showDatePicker(context),
              )
              : OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  minimumSize: const Size(double.infinity, 48.0),
                ),
                icon: const Icon(Icons.calendar_today),
                label: Text(
                  'Date: ${selectedDate.day}/${selectedDate.month}/${selectedDate.year}',
                ),
                onPressed: () => _showDatePicker(context),
              ),
    );
  }

  void _showDatePicker(BuildContext context) async {
    final bool isIOS = PlatformUtils.isIOS(context);

    if (isIOS) {
      showCupertinoModalPopup(
        context: context,
        builder: (BuildContext context) {
          return Container(
            height: 216,
            padding: const EdgeInsets.only(top: 6.0),
            margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom,
            ),
            color: CupertinoColors.systemBackground.resolveFrom(context),
            child: SafeArea(
              top: false,
              child: CupertinoDatePicker(
                initialDateTime: selectedDate,
                mode: CupertinoDatePickerMode.date,
                onDateTimeChanged: onDateChanged,
              ),
            ),
          );
        },
      );
    } else {
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
      );
      if (picked != null && picked != selectedDate) {
        onDateChanged(picked);
      }
    }
  }
}
