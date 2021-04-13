import 'package:flashchat/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class InputField extends StatefulWidget {
  final InputDecoration decoration;
  final TextInputType textInputType;
  final TextAlign textAlign;
  final bool autofocus;

  final void Function(String value)? onSubmitted;
  final EdgeInsets? errorPadding;

  InputField({
    required this.decoration,
    this.textInputType = TextInputType.emailAddress,
    this.textAlign = TextAlign.center,
    this.autofocus = false,
    this.onSubmitted,
    this.errorPadding,
  });

  _InputFieldState _state = _InputFieldState();

  void setError(String? newError) => _state.setError(newError);

  final TextEditingController controller = TextEditingController();

  String get text => _state.text;
  void clear() => _state.clear();

  @override
  _InputFieldState createState() {
    _state = _InputFieldState();
    return _state;
  }
}

class _InputFieldState extends State<InputField> {
  String? error;

  String get text => widget.controller.text.trim();
  void clear() => widget.controller.clear();

  void setError(String? newError) {
    if (mounted) setState(() => error = newError);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: widget.controller,
          autofocus: widget.autofocus,
          keyboardType: widget.textInputType,
          textAlign: widget.textAlign,
          decoration: widget.decoration,
          cursorColor: kUIAccent,
          onSubmitted: widget.onSubmitted,
        ),
        Padding(
          padding: widget.errorPadding ?? screenSize.fromLTRB(8, 4, 0, 8),
          child: error != null && error != ""
              ? Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: Colors.redAccent,
                      size: screenSize.height(20),
                    ),
                    SizedBox(width: screenSize.width(4)),
                    Text(
                      error!,
                      style: TextStyle(color: Colors.redAccent),
                    ),
                  ],
                )
              : Container(),
        ),
      ],
    );
  }
}
