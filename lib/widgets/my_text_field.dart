import 'package:flutter/material.dart';
import '../const/custom_styles.dart';

class MyTextField extends StatelessWidget {
  const MyTextField(
      {super.key,
        required this.hintText,
        required this.inputType,
        required this.textEditingController});
  final String hintText;
  final TextInputType inputType;
  final TextEditingController textEditingController;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextField(
        controller: textEditingController,
        style: kBodyText.copyWith(color: const Color.fromRGBO(242, 242, 242, 1)),
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.all(20),
          hintText: hintText,
          hintStyle: kBodyText,
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(242, 242, 242, 1),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Color.fromRGBO(242, 242, 242, 1),
              width: 1.5,
            ),
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
    );
  }
}