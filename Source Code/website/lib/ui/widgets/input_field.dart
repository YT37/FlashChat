import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InputField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType textInputType;
  final InputDecoration decoration;
  final bool autofocus;
  final bool hideText;
  final bool enabled;
  final int maxLines;

  final TextInputAction? textInputAction;
  final void Function(String value)? onSubmitted;
  final void Function(String value)? onChanged;
  final FocusNode? focusNode;
  final int? maxLength;
  final String? error;

  const InputField({
    super.key,
    required this.controller,
    required this.decoration,
    this.textInputType = TextInputType.emailAddress,
    this.enabled = true,
    this.maxLines = 1,
    this.hideText = false,
    this.autofocus = false,
    this.textInputAction,
    this.onSubmitted,
    this.onChanged,
    this.focusNode,
    this.maxLength,
    this.error,
  });

  @override
  Widget build(BuildContext context) {
    final RxBool hide = true.obs;

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Align(
        child: Column(
          children: [
            Obx(
              () => Stack(
                alignment: AlignmentDirectional.centerEnd,
                children: [
                  TextField(
                    maxLength: maxLength,
                    enabled: enabled,
                    minLines: 1,
                    textCapitalization: hideText
                        ? TextCapitalization.none
                        : TextCapitalization.words,
                    maxLines: maxLines,
                    textInputAction: textInputAction ??
                        (onSubmitted == null
                            ? TextInputAction.next
                            : TextInputAction.done),
                    keyboardType: textInputType,
                    decoration: decoration,
                    autofocus: autofocus,
                    controller: controller,
                    obscureText: hideText ? hide.value : !hide.value,
                    focusNode: focusNode,
                    onSubmitted: onSubmitted,
                    onChanged: onChanged,
                  ),
                  if (hideText)
                    IconButton(
                      highlightColor: const Color.fromRGBO(0, 0, 0, 0),
                      icon: hide.value
                          ? const Icon(Icons.visibility)
                          : const Icon(Icons.visibility_off),
                      onPressed: () => hide.toggle(),
                    ),
                ],
              ),
            ),
            if (error != null && (error?.isNotEmpty ?? false))
              Container(
                margin: const EdgeInsets.all(8),
                child: Row(
                  children: [
                    Icon(
                      Icons.error_outline,
                      color: context.theme.colorScheme.error,
                      size: 20,
                    ),
                    const SizedBox(width: 4),
                    Flexible(
                      child: AutoSizeText(
                        error!,
                        maxLines: 2,
                        style: context.textTheme.bodySmall!
                            .copyWith(color: context.theme.colorScheme.error),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
