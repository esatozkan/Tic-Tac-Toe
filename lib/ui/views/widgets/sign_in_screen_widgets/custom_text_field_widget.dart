// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatefulWidget {
  final String text;
  final TextEditingController textEditingController;
  final FocusNode focusNode;
  const CustomTextFieldWidget({
    super.key,
    required this.text,
    required this.textEditingController,
    required this.focusNode,
  });

  @override
  State<CustomTextFieldWidget> createState() => _CustomTextFieldWidgetState();
}

class _CustomTextFieldWidgetState extends State<CustomTextFieldWidget> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
      child: TextField(
        focusNode: widget.focusNode,
        controller: widget.textEditingController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Theme.of(context).colorScheme.primary,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          hintText: widget.text,
          hintStyle: TextStyle(
            fontFamily: "poppins",
            fontSize: 14,
            color: Theme.of(context).colorScheme.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        cursorColor: Theme.of(context).colorScheme.primary,
        style: TextStyle(color: Theme.of(context).colorScheme.primary),
      ),
    );
  }
}
