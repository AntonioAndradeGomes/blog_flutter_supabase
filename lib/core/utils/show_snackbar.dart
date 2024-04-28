import 'package:flutter/material.dart';

void showSnackBar({
  required BuildContext context,
  required String content,
  Color? backgroundColor,
}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          content,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        backgroundColor: backgroundColor,
      ),
    );
}
