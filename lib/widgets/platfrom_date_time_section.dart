import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:native_setup/utils/platform_utils.dart';
import 'package:native_setup/widgets/platform_text.dart';
import 'package:native_setup/widgets/platform_time_picker.dart';
import 'package:native_setup/widgets/platfrom_date_picker.dart';

class PlatformDateTimeSection extends StatelessWidget {
  final String title;
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime) onDateChanged;
  final Function(TimeOfDay) onTimeChanged;

  const PlatformDateTimeSection({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.selectedTime,
    required this.onDateChanged,
    required this.onTimeChanged,
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
          const SizedBox(height: 16.0),

          // Date Picker
          PlatformDatePicker(
            selectedDate: selectedDate,
            onPressed: () {},
            onDateChanged: onDateChanged,
          ),

          // Time Picker
          PlatformTimePicker(
            selectedDate: selectedDate,
            selectedTime: selectedTime,
            onTimeChanged: onTimeChanged,
          ),
        ],
      ),
    );
  }
}
