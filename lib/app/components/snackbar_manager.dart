import 'package:flutter/material.dart';

class SnackBarManager {
  void _show(BuildContext context, String message, IconData icon, Color color,
      {Color background = Colors.white}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: background,
        content: Row(
          children: [
            Icon(
              icon,
              color: color,
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Text(
                message,
                style: TextStyle(fontSize: 17, color: color),
              ),
            ),
            /* InkWell(
              onTap: () {
                ScaffoldMessenger.of(context).hideCurrentSnackBar();
              },
              child: const Padding(
                padding: EdgeInsets.all(4),
                child: Icon(Icons.close, color: Colors.black54),
              ),
            ), */
          ],
        ),
      ),
    );
  }

  showError(BuildContext context, String message) =>
      _show(context, message, Icons.warning_amber_rounded, Colors.white,
          background: const Color.fromARGB(255, 255, 0, 255));
  showWarning(BuildContext context, String message) =>
      _show(context, message, Icons.warning_amber_rounded, Colors.red);
  showSuccess(BuildContext context, String message) =>
      _show(context, message, Icons.check_circle_outline, Colors.green,
          background: Colors.green[100]!);
}
