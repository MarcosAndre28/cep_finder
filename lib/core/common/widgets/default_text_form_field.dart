import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class DefaultTextFormField extends StatelessWidget {
  const DefaultTextFormField({
    this.controller,
    this.filled = true,
    this.readOnly = false,
    this.obscureText = false,
    this.textCapitalization,
    this.focusNode,
    this.fillColor,
    this.suffixIcon,
    this.prefixIcon,
    this.minLines,
    this.maxLines,
    this.textAlign,
    this.keyboardType,
    this.onTapOutside,
    this.canRequestFocus,
    this.textStyle,
    this.contentPadding,
    this.hintText,
    this.initialValue,
    this.hintStyle,
    this.onEditingComplete,
    this.onTap,
    this.decoration,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.useDefaultValidator = false,
    this.breakErrorText = false,
    this.prefixText,
    this.errorStyle,
    super.key,
  });

  final TextEditingController? controller;
  final bool filled;
  final bool obscureText;
  final bool readOnly;
  final TextCapitalization? textCapitalization;
  final Color? fillColor;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final int? minLines;
  final int? maxLines;
  final TextInputType? keyboardType;
  final TextStyle? textStyle;
  final String? hintText;
  final TextAlign? textAlign;
  final TextStyle? hintStyle;
  final bool? canRequestFocus;
  final InputDecoration? decoration;
  final VoidCallback? onEditingComplete;
  final EdgeInsetsGeometry? contentPadding;
  final VoidCallback? onTap;
  final String? initialValue;
  final void Function(String value)? onChanged;
  final String? Function(String? value)? validator;
  final bool useDefaultValidator;
  final List<TextInputFormatter>? inputFormatters;
  final FocusNode? focusNode;
  final Function(PointerDownEvent)? onTapOutside;
  final bool breakErrorText;
  final String? prefixText;
  final TextStyle? errorStyle;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: onTap,
      textCapitalization: textCapitalization ?? TextCapitalization.sentences,
      controller: controller,
      onEditingComplete: onEditingComplete,
      onChanged: onChanged,
      initialValue: initialValue,
      canRequestFocus: canRequestFocus ?? true,
      focusNode: focusNode,
      onTapOutside: onTapOutside,
      validator: useDefaultValidator
          ? (value) {
              if (value == null || value.isEmpty) {
                return breakErrorText ? 'Campo\nobrigatório' : 'Campo obrigatório';
              }
              return validator?.call(value);
            }
          : validator,
      keyboardType: keyboardType,
      minLines: minLines,
      obscureText: obscureText,
      style: textStyle,
      readOnly: readOnly,
      textAlign: textAlign ?? TextAlign.start,
      maxLines: maxLines,
      inputFormatters: inputFormatters,
      decoration: decoration?.copyWith(
            errorStyle: errorStyle,
          ) ??
          InputDecoration(
            hintText: hintText,
            hintStyle: hintStyle ?? const TextStyle(color: Color(0xFF7C7C8A), fontSize: 14),
            filled: filled,
            fillColor: fillColor ?? const Color(0xFFEBEBEB),
            contentPadding: contentPadding ?? const EdgeInsets.only(left: 16, right: 16),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8.0)),
              borderSide: BorderSide.none,
            ),
            prefixText: prefixText,
            errorStyle: errorStyle,
          ),
    );
  }
}
