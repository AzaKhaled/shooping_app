import 'package:flutter/material.dart';
import 'package:fruits_hub/core/utils/widgets/customtextfiled.dart';

class CustomSearch extends StatelessWidget {
  final TextEditingController controller;
  final Function(String)? onChanged;

  const CustomSearch({
    super.key,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return CustomTextFormField(
      controller: controller,
      onChanged: onChanged, // الجديد
      preffixIcon: const Icon(Icons.search),
      hintText: 'Search any Product..',
      textInputType: TextInputType.text,
    );
  }
}
