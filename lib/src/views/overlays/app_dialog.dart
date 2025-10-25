import 'package:flutter/material.dart';

showAppDialog(BuildContext context, String title, String content, List<Widget> actions) {
  final size = MediaQuery.sizeOf(context);

  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      buttonPadding: EdgeInsets.zero,
      contentPadding: EdgeInsets.symmetric(horizontal: size.width * 0.048),
      titlePadding: EdgeInsets.symmetric(vertical: size.height * 0.02),
      actionsPadding: EdgeInsets.zero,
      actionsAlignment: MainAxisAlignment.center,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
        textAlign: TextAlign.center,
      ),
      content: SizedBox(
        height: size.height * 0.1,
        width: size.width,
        child: Center(
          child: Text(
            content,
            style: Theme.of(context).textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
        ),
      ),
      actions: actions,
    ),
  );
}
