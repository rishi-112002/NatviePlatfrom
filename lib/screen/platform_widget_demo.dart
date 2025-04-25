import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:native_setup/data/dummy_data.dart';
import 'package:native_setup/utils/platform_utils.dart';
import 'package:native_setup/widgets/platform_dropdown.dart';
import 'package:native_setup/widgets/platform_radio_group.dart';
import 'package:native_setup/widgets/platform_text_filed.dart';
import 'package:native_setup/widgets/platfrom_button.dart';
import 'package:native_setup/widgets/platfrom_checkbox.dart';
import 'package:native_setup/widgets/platfrom_date_time_section.dart';
import 'package:native_setup/widgets/platfrom_switch.dart';

class PlatformWidgetsDemo extends StatefulWidget {
  const PlatformWidgetsDemo({super.key});

  @override
  PlatformWidgetsDemoState createState() => PlatformWidgetsDemoState();
}

class PlatformWidgetsDemoState extends State<PlatformWidgetsDemo> {
  final TextEditingController _nameController = TextEditingController();
  String _selectedCountry = 'India';
  int _preferredContactMethod = 0;
  bool _receiveNewsletter = false;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  void _resetFormValues() {
    setState(() {
      _nameController.clear();
      _selectedCountry = countries[0];
      _preferredContactMethod = 0;
      for (int i = 0; i < interestsValues.length; i++) {
        interestsValues[i] = false;
      }
      _receiveNewsletter = false;
      _selectedDate = DateTime.now();
      _selectedTime = TimeOfDay.now();
    });
    FocusScope.of(context).unfocus();
  }

  // Updated handler for the list of checkbox values
  void _handleCheckboxChanged(int index, bool? value) {
    if (value == null || index < 0 || index >= interestsValues.length) return;
    setState(() {
      interestsValues[index] = value;
    });
  }

  void _handleFormSubmit() {
    final formData = {
      'name': _nameController.text,
      'country': _selectedCountry,
      'contactMethod': contactMethodLabels[_preferredContactMethod],
      'interests':
          Map.fromIterables(
            interestLabels,
            interestsValues,
          ).entries.where((e) => e.value).map((e) => e.key).toList(),
      'newsletter': _receiveNewsletter,
      'appointmentDate': _selectedDate.toIso8601String().split('T')[0],
      'appointmentTime': _selectedTime.format(context),
    };

    print('Form Data: $formData');

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Form submitted! Check console for data.'),
        duration: Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    // Native header (AppBar/CupertinoNavigationBar)
    final PreferredSizeWidget appBar =
        isIOS
            ? CupertinoNavigationBar(
              middle: const Text('User Registration'),
              trailing: CupertinoButton(
                padding: EdgeInsets.zero,
                onPressed: _resetFormValues,
                child: const Icon(CupertinoIcons.refresh),
              ),
            )
            : AppBar(
              title: const Text('User Registration'),
              actions: [
                IconButton(
                  icon: const Icon(Icons.refresh),
                  tooltip: 'Reset Form',
                  onPressed: _resetFormValues,
                ),
              ],
            );
    Widget body = ListView(
      padding: const EdgeInsets.all(16.0),
      children: [
        // 1. Text input field
        PlatformTextField(
          controller: _nameController,
          placeholder: 'Enter your full name',
        ),

        // 2. Dropdown
        PlatformDropdown(
          title: 'Country',
          value: _selectedCountry,
          items: countries,
          onChanged: (String newValue) {
            setState(() {
              _selectedCountry = newValue;
            });
          },
        ),

        // 3. Radio button options
        PlatformRadioGroup(
          title: 'Preferred Contact Method',
          value: _preferredContactMethod,
          labels: contactMethodLabels,
          onChanged: (int? value) {
            if (value != null) {
              setState(() {
                _preferredContactMethod = value;
              });
            }
          },
        ),

        // 4. Checkbox options
        PlatformCheckboxGroup(
          title: 'Interests',
          values: interestsValues,
          labels: interestLabels,
          onChanged: _handleCheckboxChanged,
        ),

        // 5. Switch
        PlatformSwitch(
          title: 'Settings',
          label: 'Receive Newsletter',
          value: _receiveNewsletter,
          onChanged: (bool value) {
            setState(() {
              _receiveNewsletter = value;
            });
          },
        ),

        PlatformDateTimeSection(
          title: 'Schedule Appointment',
          selectedDate: _selectedDate,
          selectedTime: _selectedTime,
          onDateChanged: (DateTime newDate) {
            setState(() {
              _selectedDate = newDate;
            });
          },
          onTimeChanged: (TimeOfDay newTime) {
            setState(() {
              _selectedTime = newTime;
            });
          },
        ),

        // 7. Native button (Submit)
        PlatformButton(
          label: 'Submit Registration',
          onPressed: _handleFormSubmit,
          title: 'Submit Registration',
        ),
        const SizedBox(height: 20),
      ],
    );

    // Return the appropriate scaffold based on the platform
    return isIOS
        ? CupertinoPageScaffold(
          navigationBar: appBar as CupertinoNavigationBar,
          child: SafeArea(child: body),
        )
        : Scaffold(appBar: appBar, body: body);
  }
}
