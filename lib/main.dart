import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:icecream_shop/src/core/utils/dependency_injection.dart';
import 'package:icecream_shop/src/core/utils/routes.dart';
import 'package:icecream_shop/src/features/presenter/pages/ice_creams_page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DependencyInjection.init();
  runApp(
    GetMaterialApp(
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en', ''),
        Locale('es', ''),
      ],
      debugShowCheckedModeBanner: false,
      smartManagement: SmartManagement.keepFactory,
      home: IceCreamsPage(),
      theme: ThemeData(
        fontFamily: 'Poppins',
      ),
      getPages: AppRoutes.pages,
    ),
  );
}
