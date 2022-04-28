import 'package:flutter/material.dart';

class CustomDropdownButton extends StatelessWidget {
  final Color fillColor;
  final String value;
  final List<DropdownMenuItem<String>>? items;
  final ValueSetter<String?> onChanged;
  final double borderWidth;
  final Color borderColor;
  final double borderRadius;
  final Icon trailingIcon;
  final Color dropdownColor;

  const CustomDropdownButton({
    this.borderRadius = 8,
    this.borderColor = Colors.black,
    this.borderWidth = 2,
    this.fillColor = Colors.white,
    required this.value,
    required this.items,
    required this.onChanged,
    this.trailingIcon = const Icon(
      Icons.keyboard_arrow_down_sharp,
      color: Colors.black,
    ),
    this.dropdownColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(this.borderRadius),
        border: Border.all(
          color: this.borderColor,
          width: this.borderWidth,
        ),
        color: this.fillColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 3,
        ),
        child: DropdownButton<String>(
          underline: SizedBox(),
          value: this.value,
          items: this.items,
          elevation: 5,
          onChanged: this.onChanged,
          icon: this.trailingIcon,
          isExpanded: true,
          dropdownColor: this.dropdownColor,
        ),
      ),
    );
  }
}
