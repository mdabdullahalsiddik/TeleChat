// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:telechat/utils/static/all_colors.dart';

class CustomButton extends StatelessWidget {
  final String? text;
  final void Function()? onTap;
  const CustomButton({
    super.key,
    required this.text,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.07,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          color: Theme.of(context).colorScheme.primary,
          child: Center(
            child: Text(
              text ?? "",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    color: AllColors.whiteColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
            ),
          ),
        ),
      ),
    );
  }
}
