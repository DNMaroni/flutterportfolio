import 'package:flutter/material.dart';

/* class DialogCustom extends StatelessWidget {
  final BuildContext contextoo;

  const DialogCustom({Key? key, required this.contextoo}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('AlertDialog Title'),
      content: SingleChildScrollView(
        child: ListBody(
          children: const <Widget>[
            Text('This is a demo alert dialog.'),
            Text('Would you like to approve of this message?'),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Approve'),
          onPressed: () {
            Navigator.of(contextoo).pop();
          },
        ),
      ],
    );
  }
}
 */

class DialogCustom {
  static Future run(
      BuildContext context,
      String title,
      /* String message, */
      Function onPressed) async {
    return await showDialog(
      context: context,
      builder: (BuildContext contextaqui) {
        return AlertDialog(
          title: Text(title),
          /*  content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(message),
              ],
            ),
          ), */
          actions: <Widget>[
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.of(contextaqui).pop();
                  },
                  icon: const Icon(Icons.close),
                  label: const Text('Não'),
                ),
                const Spacer(),
                ElevatedButton.icon(
                  onPressed: () {
                    onPressed();
                    Navigator.of(contextaqui).pop();
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Sim'),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
