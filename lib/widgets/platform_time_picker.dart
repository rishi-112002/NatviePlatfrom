import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

class PlatformTimePicker extends StatelessWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(TimeOfDay) onTimeChanged;

  const PlatformTimePicker({
    super.key,
    required this.selectedDate,
    required this.selectedTime,
    required this.onTimeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    return SizedBox(
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
                      'Time: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
                      style: const TextStyle(color: CupertinoColors.label),
                    ),
                    const Icon(
                      CupertinoIcons.clock,
                      color: CupertinoColors.label,
                    ),
                  ],
                ),
                onPressed: () => _showTimePicker(context),
              )
              : OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    vertical: 16.0,
                    horizontal: 16.0,
                  ),
                  minimumSize: const Size(double.infinity, 48.0),
                ),
                icon: const Icon(Icons.access_time),
                label: Text(
                  'Time: ${selectedTime.hour}:${selectedTime.minute.toString().padLeft(2, '0')}',
                ),
                onPressed: () => _showTimePicker(context),
              ),
    );
  }

  void _showTimePicker(BuildContext context) async {
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
                initialDateTime: DateTime(
                  selectedDate.year,
                  selectedDate.month,
                  selectedDate.day,
                  selectedTime.hour,
                  selectedTime.minute,
                ),
                mode: CupertinoDatePickerMode.time,
                onDateTimeChanged: (DateTime newDateTime) {
                  onTimeChanged(
                    TimeOfDay(
                      hour: newDateTime.hour,
                      minute: newDateTime.minute,
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    } else {
      final TimeOfDay? picked = await showTimePicker(
        context: context,
        initialTime: selectedTime,
      );
      if (picked != null && picked != selectedTime) {
        onTimeChanged(picked);
      }
    }
  }
}
