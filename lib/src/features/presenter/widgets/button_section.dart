import 'package:flutter/material.dart';

Widget buttonSection({
  required int quantity,
  required Function changeQuantity,
  required int iIceCream,
  required int iPrice,
}) {
  return Row(
    children: [
      buttonModel(
          () => changeQuantity(
              iIceCream: iIceCream, iPrice: iPrice, operator: '-'),
          '-'),
      Container(
        alignment: Alignment.center,
        width: 30,
        child: Text(
          quantity.toString(),
        ),
      ),
      buttonModel(
          () => changeQuantity(
              iIceCream: iIceCream, iPrice: iPrice, operator: '+'),
          '+'),
    ],
  );
}

Widget buttonModel(Function onTap, String text) {
  return TextButton(
    style: TextButton.styleFrom(
      backgroundColor: Colors.grey[200],
      padding: EdgeInsets.zero,
      minimumSize: const Size(35, 35),
    ),
    onPressed: () => onTap(),
    child: Text(
      text,
      style: const TextStyle(color: Colors.deepPurpleAccent),
    ),
  );
}
