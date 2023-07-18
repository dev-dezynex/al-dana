import 'package:al_dana/app/modules/invoice/provider/invoice_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'app/data/data.dart';
import 'app/routes/app_pages.dart';
import 'package:provider/provider.dart';
void main() async {
  await GetStorage.init();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    debugPaintSizeEnabled = false;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),
      ],
      child: GetMaterialApp(
        title: "Al Dana",
        debugShowCheckedModeBanner: false,
        theme: MyTheme.themeData(isDarkTheme: false, context: context),
        darkTheme: MyTheme.themeData(isDarkTheme: true, context: context),
        themeMode: ThemeMode.light,
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        unknownRoute: AppPages.routes[0],
      ),
    );
  }
}
