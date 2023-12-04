import 'package:flutter/material.dart';


class SearchWidget extends StatelessWidget {
  final TextEditingController controller;
  final bool isEnabled;
  final Color? backgroundColor;
  final BoxBorder? border;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? hintText;
  final bool? obscureText;
  void Function(String)? onChanged;
  final FocusNode? focusNode;
  BorderRadiusGeometry? borderRadius;
  final InputBorder? focusedBorder;

  final TextInputType? keyboardType;

  final int? maxLines;
  final int? maxLength;

  final String? Function(String?)? validator;

  SearchWidget(
      {Key? key,
        required this.controller,
        required this.isEnabled,
        this.backgroundColor,
        this.focusNode,
        this.maxLength,
        this.border,
        this.prefixIcon,
        this.hintText,
        this.onChanged,
        this.suffixIcon,
        this.obscureText,
        this.focusedBorder,
        this.borderRadius,
        this.keyboardType,
        this.maxLines,
        this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      // width: double.infinity,
      // height: 56,
      decoration: BoxDecoration(
          color: backgroundColor ?? Colors.white,
          borderRadius: borderRadius ?? BorderRadius.circular(4),
          boxShadow: (focusNode?.hasFocus == true)
              ? [
            BoxShadow(
              color: Colors.black.withOpacity(0.18),
              offset: const Offset(0, 6),
              blurRadius: 20,
              spreadRadius: 0,
            )
          ]
              : null
        // border:  (focusedBorder != null)? null :border
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        validator: validator ?? null,
        enabled: isEnabled,
        keyboardType: keyboardType ?? TextInputType.text,
        focusNode: focusNode,
        obscureText: obscureText ?? false,
        maxLines: maxLines ?? 1,
        maxLength: maxLength,
        style: TextStyle(fontSize: 14, color:  Colors.grey.shade500),
        decoration: InputDecoration(
          border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(Radius.circular(4.0)),
              borderSide: BorderSide(color: Colors.grey.shade300)),
          focusedBorder: focusedBorder,
          prefixIcon: prefixIcon,
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.all(12.0),
          hintStyle: TextStyle(fontSize: 12, color: Colors.grey.shade500),
          hintText: hintText ?? "Search here",
          // hintStyle: getRegularStyle(
          //     fontSize: 14,color: ColorManager.gray400
          // )
        ),
      ),
    );
  }
}
