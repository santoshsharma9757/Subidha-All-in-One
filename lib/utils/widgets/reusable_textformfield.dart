import 'package:flutter/material.dart';

class ReusableTextFormField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final String? Function(String?)? validator;
  final Color? backgroundColor;
  final Icon? suffixIcon;

  const ReusableTextFormField({
    Key? key,
    required this.labelText,
    required this.controller,
    this.keyboardType = TextInputType.number,
    this.validator,
    this.backgroundColor = Colors.white, 
    this.suffixIcon
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.grey),
      ),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: labelText,
          border: InputBorder.none, // Remove the default border
          contentPadding: EdgeInsets.all(16.0), 
          
          suffixIcon: suffixIcon
        ),
        validator: validator,
      
      ),
    );
  }
}
