// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_little_app/common/presentation/build_context_extensions.dart';
import 'package:my_little_app/common/presentation/svg_assets.dart';

class FakeStoreTextField extends StatefulWidget {
  final String fieldName;
  final bool isPassword;
  final TextEditingController? textEditingController;
  final FormFieldValidator<String>? validator;
  final EdgeInsetsGeometry? padding;
  final TextInputType? keyboardType;

  final String hint;
  const FakeStoreTextField._({
    super.key,
    required this.hint,
    required this.fieldName,
    this.isPassword = false,
    this.textEditingController,
    this.validator,
    this.padding,
    this.keyboardType,
  });

  factory FakeStoreTextField.password({
    required String fieldName,
    required String hintText,
    FormFieldValidator<String>? validator,
    EdgeInsetsGeometry? padding,
  }) =>
      FakeStoreTextField._(
        hint: hintText,
        fieldName: fieldName,
        validator: validator,
        isPassword: true,
        padding: padding,
      );

  factory FakeStoreTextField.email({
    required String fieldName,
    required String hintText,
    FormFieldValidator<String>? validator,
    EdgeInsetsGeometry? padding,
  }) =>
      FakeStoreTextField._(
        hint: hintText,
        fieldName: fieldName,
        validator: validator,
        padding: padding,
        keyboardType: TextInputType.emailAddress,
      );

  @override
  State<FakeStoreTextField> createState() => _FakeStoreTextFieldState();
}

class _FakeStoreTextFieldState extends State<FakeStoreTextField> {
  late bool isHidden;
  @override
  void initState() {
    isHidden = widget.isPassword;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? EdgeInsets.zero,
      child: FormBuilderTextField(
        validator: widget.validator,
        name: widget.fieldName,
        obscureText: isHidden,
        keyboardType: widget.keyboardType,
        cursorColor: context.appColors.secondary,
        style: TextStyle(color: context.appColors.secondary),
        decoration: InputDecoration(
          suffixIcon: widget.isPassword
              ? InkWell(
                  borderRadius: BorderRadius.circular(40),
                  onTap: () => _toggleTextVisibility(),
                  child: SvgPicture.asset(
                    colorFilter: ColorFilter.mode(
                      context.appColors.secondary ?? Colors.pink,
                      BlendMode.srcIn,
                    ),
                    isHidden ? SvgAssets.eyeClosed : SvgAssets.eyeOpened,
                    fit: BoxFit.scaleDown,
                  ),
                )
              : null,
          hintText: widget.hint,
          hintStyle: TextStyle(
            color: context.appColors.secondary,
          ),
          labelStyle: TextStyle(
            color: context.appColors.secondary,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: context.appColors.textFieldBorder ?? Colors.pink),
            borderRadius: const BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: context.appColors.textFieldBorder ?? Colors.pink,
              width: 1,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red,
              width: 0.9,
            ),
            borderRadius: BorderRadius.all(
              Radius.circular(15),
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.red.shade600,
              width: 1.5,
            ),
            borderRadius: const BorderRadius.all(
              Radius.circular(15),
            ),
          ),
        ),
      ),
    );
  }

  void _toggleTextVisibility() {
    setState(() => isHidden = !isHidden);
  }
}
