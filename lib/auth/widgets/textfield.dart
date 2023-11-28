import 'package:flutter/material.dart';

import '../../const.dart';

class MyTextField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData suffixIcon;
  final TextInputType textType;
  final bool autoFocus;
  final VoidCallback onInteraction;

  MyTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.suffixIcon,
    required this.textType,
    required this.autoFocus,
    required this.onInteraction,
  }) : super(key: key);

  @override
  _MyTextFieldState createState() => _MyTextFieldState();
}

class _MyTextFieldState extends State<MyTextField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Focus(
        onFocusChange: (hasFocus) {
          setState(() {
            isFocused = hasFocus;
          });
        },
        child: TextField(
          keyboardType: widget.textType,
          controller: widget.controller,
          obscureText: widget.obscureText,
          autofocus: widget.autoFocus,
          onChanged: (value) {
            widget.onInteraction();
          },
          decoration: InputDecoration(
            suffixIcon: Icon(
              widget.suffixIcon,
              color: isFocused ? btn_color : dark_gray,
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: inputField),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: btn_color),
            ),
            fillColor: inputField,
            filled: true,
            iconColor: dark_gray,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: dark_gray, fontSize: 22),
          ),
        ),
      ),
    );
  }
}

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final IconData suffixIcon;
  final TextInputType textType;
  final bool autoFocus;
  final VoidCallback onInteraction;

  const PhoneInputField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.suffixIcon,
      required this.textType,
      required this.autoFocus,
      required this.onInteraction});

  @override
  State<PhoneInputField> createState() => _PhoneInputFieldState();
}

class _PhoneInputFieldState extends State<PhoneInputField> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 15),
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: inputField,
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(12),
                  topLeft: Radius.circular(12))),
          child: Text(
            '+251',
            style: TextStyle(fontSize: 18.0, color: dark_gray),
          ),
        ),
        // Add some spacing between the prefix and the editable part
        Expanded(
            child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Focus(
            onFocusChange: (hasFocus) {
              setState(() {
                isFocused = hasFocus;
              });
            },
            child: TextField(
              keyboardType: widget.textType,
              controller: widget.controller,
              obscureText: widget.obscureText,
              autofocus: widget.autoFocus,
              onChanged: (value) {
                widget.onInteraction();
              },
              decoration: InputDecoration(
                  suffixIcon: Icon(
                    widget.suffixIcon,
                    color: isFocused ? btn_color : dark_gray,
                  ),
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: inputField),
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(12),
                          topRight: Radius.circular(12))),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: btn_color)),
                  fillColor: inputField,
                  filled: true,
                  hintText: widget.hintText,
                  hintStyle: TextStyle(color: dark_gray, fontSize: 22)),
            ),
          ),
        )),
      ],
    );
  }
}

class MyPinField extends StatefulWidget {
  final controller;
  final String hintText;
  final TextInputType textType;
  final bool autoFocus;
  final VoidCallback onInteraction;

  const MyPinField(
      {super.key,
      this.controller,
      required this.hintText,
      required this.textType,
      required this.autoFocus,
      required this.onInteraction});

  @override
  State<MyPinField> createState() => _MyPinFieldState();
}

class _MyPinFieldState extends State<MyPinField> {
  bool isVisible = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: TextField(
        keyboardType: widget.textType,
        controller: widget.controller,
        obscureText: isVisible,
        autofocus: widget.autoFocus,
        onChanged: (value) {
          widget.onInteraction();
        },
        decoration: InputDecoration(
            suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    isVisible = !isVisible;
                  });
                },
                //   icon: Visibility(
                //   visible: isVisible,
                //   child: Icon(Icons.visibility_off),
                //   replacement: Icon(Icons.visibility),
                // ),
                icon: Icon(
                  isVisible ? Icons.visibility_off : Icons.visibility,
                  color: isVisible ? dark_gray : btn_color,
                )),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: inputField),
              borderRadius: BorderRadius.circular(12),
            ),
            focusedBorder:
                OutlineInputBorder(borderSide: BorderSide(color: btn_color)),
            fillColor: inputField,
            filled: true,
            iconColor: btn_color,
            hintText: widget.hintText,
            hintStyle: TextStyle(color: dark_gray, fontSize: 22)),
      ),
    );
  }
}
