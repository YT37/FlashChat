import 'package:flashchat/constants.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class PasswordField extends StatefulWidget {
  final InputDecoration decoration;
  final TextAlign textAlign;
  final bool autofocus;

  final void Function(String value)? onSubmitted;
  final FocusNode? node;
  final EdgeInsets? errorPadding;

  PasswordField({
    required this.decoration,
    this.textAlign = TextAlign.center,
    this.autofocus = false,
    this.onSubmitted,
    this.node,
    this.errorPadding,
  });

  _PasswordFieldState _state = _PasswordFieldState();

  void setError(String? newError) => _state.setError(newError);

  final TextEditingController controller = TextEditingController();

  String get pass => _state.pass;
  void clear() => _state.clear();

  @override
  _PasswordFieldState createState() {
    _state = _PasswordFieldState();
    return _state;
  }
}

class _PasswordFieldState extends State<PasswordField> {
  String? error;

  String get pass => widget.controller.text.trim();
  void clear() => widget.controller.clear();

  void setError(String? newError) {
    if (mounted) setState(() => error = newError);
  }

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.centerEnd,
          children: [
            TextField(
              obscureText: hide,
              autofocus: widget.autofocus,
              focusNode: widget.node,
              textAlign: widget.textAlign,
              controller: widget.controller,
              cursorColor: kUIAccent,
              decoration: widget.decoration,
              onSubmitted: widget.onSubmitted,
            ),
            IconButton(
              highlightColor: Colors.transparent,
              color: Colors.grey.shade700,
              icon: hide ? Icon(Icons.visibility) : Icon(Icons.visibility_off),
              onPressed: () => setState(() => hide = !hide),
            )
          ],
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
