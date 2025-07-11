import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/widgets/customtextfiled.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    super.key,
    this.onSaved,
    required this.hintText,
    this.controller,
    this.validator,
  });

  final void Function(String?)? onSaved;
  final String hintText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool obscureText = true;

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: widget.controller,
      obscureText: obscureText,
      onSaved: widget.onSaved,
      validator: widget.validator,
      preffixIcon:  Icon(Icons.lock_outline ,color: Theme.of(context).iconTheme.color,),
      suffixIcon: GestureDetector(
        onTap: () {
          setState(() {
            obscureText = !obscureText;
          });
        },
        child: Icon(
          obscureText ? Icons.remove_red_eye : Icons.visibility_off,
          color: Theme.of(context).iconTheme.color,
        ),
      ),
      hintText: widget.hintText,
      textInputType: TextInputType.visiblePassword,
    );
  }
}
