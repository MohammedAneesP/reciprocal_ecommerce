
import 'package:flutter/material.dart';

class AddressTextForm extends StatelessWidget {
  const AddressTextForm({
    super.key,
    required this.anEmailEditingController,
    required this.returnText,
    required this.anLabelText,
    required this.isObscure,
    required this.anPrefixIcon,
    this.anSuffixIcon,
    required this.keyInputType,
    required this.maxLines,
  });

  final TextEditingController anEmailEditingController;

  final String returnText;
  final String anLabelText;
  final bool isObscure;
  final Icon anPrefixIcon;
  final dynamic anSuffixIcon;
  final TextInputType keyInputType;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "please fill these";
        }
        return null;
      },
      maxLines: maxLines,
      controller: anEmailEditingController,
      keyboardType: keyInputType,
      decoration: InputDecoration(
          prefixIcon: anPrefixIcon,
          labelText: anLabelText,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          )),
    );
  }
}
