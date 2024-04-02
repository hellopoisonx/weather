import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:weather/bindings/bindings.dart';
import 'package:weather/pages/home.dart';
import 'package:weather/pages/region.dart';
import 'package:weather/themes/dark.dart';

void main() async {
  await initializeDateFormatting('zh_CN', null);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      defaultTransition: Transition.zoom,
      transitionDuration: const Duration(milliseconds: 250),
      getPages: [
        GetPage(
          name: "/",
          page: () => const SafeArea(child: Home()),
        ),
        GetPage(
          name: "/region",
          page: () => const SafeArea(child: Region()),
          binding: RegionBinding(),
        ),
      ],
      title: "weather",
      theme: darkThemeData,
      darkTheme: darkThemeData,
      initialRoute: "/",
      initialBinding: RootBinding(),
    );
  }
}
