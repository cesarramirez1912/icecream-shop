import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/core/utils/routes.dart';

import '../../../core/utils/palette.dart';

Widget drawerMenu() {
  void verifyRouter(String route) {
    if (Get.currentRoute == route) {
      Get.back();
    } else {
      Get.toNamed(route);
    }
  }

  List<Widget> _defaultItems = [
    ListTile(
        title: const Text('Inicio'),
        onTap: () => verifyRouter(AppRoutes.ICE_CREAMS)),
    ListTile(
      title: const Text('Ventas'),
      onTap: () => verifyRouter(AppRoutes.VENTAS),
    ),
  ];

  return Drawer(
    child: Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        DrawerHeader(
          decoration: const BoxDecoration(
            color: Palette.PRIMARY,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Casquinha',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.w700),
              ),
              Text(
                'Helados soft',
                style: TextStyle(color: Colors.black),
              )
            ],
          ),
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [..._defaultItems],
            ),
          ),
        )
      ],
    ),
  );
}
