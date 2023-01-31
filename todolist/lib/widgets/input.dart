import 'package:flutter/material.dart';
import 'package:todolist/tool/color.dart';

class InputField extends StatefulWidget {
  const InputField(
      {Key? key,
      required this.title,
      required this.hintText,
      this.onValueChanged})
      : super(key: key);

  final String title;
  final String hintText;
  final ValueChanged<String>? onValueChanged;

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();

    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(widget.title),
        TextField(
          controller: TextEditingController(text: widget.title),
          style: const TextStyle(
              color: Colors.white, fontSize: 18, fontWeight: FontWeight.w400),
          maxLines: 1,
          keyboardAppearance: Brightness.dark,
          textInputAction: TextInputAction.newline,
          cursorColor: CustomColors.orangeColor,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: const TextStyle(
                color: CustomColors.subTitleColor,
                fontSize: 18,
                fontWeight: FontWeight.w400),
            contentPadding: const EdgeInsets.all(10.0),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                    style: BorderStyle.solid)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(0.0),
                borderSide: const BorderSide(
                    color: Colors.transparent,
                    width: 0,
                    style: BorderStyle.solid)),
          ),
          onChanged: widget.onValueChanged,
          onEditingComplete: _onEidtingComplete,
          onSubmitted: _onSubmitted,
        )
      ],
    );
  }

  String showText() {
    return _controller.value.text;
  }

  void _onChanged(String value) {
    print("_onChanged");
  }

  void _onEidtingComplete() {
    print("_onEidtingComplete");
  }

  void _onSubmitted(String value) {
    print("_onSubmitted");
    // _saveTodo();
  }
}
