import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future dialog(BuildContext context, String text) {
  Widget cancelButton = TextButton(
    child: const Text("Cancelar"),
    onPressed: () => Navigator.of(context).pop(false),
  );
  Widget continueButton = TextButton(
      child: const Text("Confirmar"),
      onPressed: () => Navigator.of(context).pop(true));

  AlertDialog alert = AlertDialog(
    title: const Text("Desea eliminar venta ?"),
    actions: [continueButton, cancelButton],
    content: Column(
      mainAxisSize: MainAxisSize.min,
      children: [Text(text)],
    ),
  );

  // show the dialog
  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
