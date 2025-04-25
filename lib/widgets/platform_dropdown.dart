import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import '../utils/platform_utils.dart';

class PlatformDropdown extends StatefulWidget {
  final String title;
  final String value;
  final List<String> items;
  final ValueChanged<String> onChanged;

  const PlatformDropdown({
    super.key,
    required this.title,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  State<PlatformDropdown> createState() => PlatformDropdownState();
}

class PlatformDropdownState extends State<PlatformDropdown> {
  @override
  Widget build(BuildContext context) {
    final bool isIOS = PlatformUtils.isIOS(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.title,
            style:
                isIOS
                    ? const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: CupertinoColors.black,
                    )
                    : Theme.of(context).textTheme.titleMedium!.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 16.0,
                      color: CupertinoColors.black,
                    ),
          ),
          const SizedBox(height: 8.0),
          isIOS ? _buildCupertinoDropdown() : _buildMaterialDropdown(),
        ],
      ),
    );
  }

  Widget _buildCupertinoDropdown() {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        decoration: BoxDecoration(
          border: Border.all(color: CupertinoColors.systemGrey),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(widget.value),
            const Icon(CupertinoIcons.chevron_down),
          ],
        ),
      ),
      onPressed: () {
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
                child: CupertinoPicker(
                  magnification: 1.22,
                  squeeze: 1.2,
                  useMagnifier: true,
                  itemExtent: 32.0,
                  onSelectedItemChanged: (int selectedItem) {
                    widget.onChanged(widget.items[selectedItem]);
                  },
                  children:
                      widget.items
                          .map((String value) => Center(child: Text(value)))
                          .toList(),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildMaterialDropdown() {
    return DropdownButton<String>(
      isExpanded: true,
      value: widget.value,
      icon: const Icon(Icons.arrow_downward),
      iconSize: 24,
      elevation: 16,
      underline: Container(height: 2, color: Theme.of(context).primaryColor),
      onChanged: (String? newValue) {
        if (newValue != null) {
          widget.onChanged(newValue);
        }
      },
      items:
          widget.items.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(value: value, child: Text(value));
          }).toList(),
    );
  }
}
