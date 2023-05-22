import 'package:flutter/material.dart';

class SnackbarComponent extends StatelessWidget {
  final String message;

  const SnackbarComponent({Key? key, required this.message}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextButton(
        onPressed: () {
          final snackBar = SnackBar(
            content: Text(message),
            action: SnackBarAction(
              label: 'Desfazer',
              onPressed: () {
                // Algum código para desfazer alguma alteração
              },
            ),
          );

          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        },
        child: const Text('Show SnackBar'),
      ),
    );
  }
}
