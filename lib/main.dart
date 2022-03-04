import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:shop_app/constance.dart';
import 'package:shop_app/language/localization.dart';
import 'package:shop_app/routes/routes.dart';
import 'package:shop_app/view/splash_view.dart';
import 'package:shop_app/view_model/bindings/bindings.dart';
import 'package:shop_app/view_model/setting_controller.dart';

void main() async {
  await GetStorage.init();
  runApp(DevicePreview(builder: (context) => MyApp()));
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
}

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => ScreenUtilInit(
      designSize: const Size(392, 850),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: () => GetMaterialApp(
          themeMode: SettingController().theme,
          useInheritedMediaQuery: true,
          locale: Locale(GetStorage().read("langauge") ?? "en"),
          fallbackLocale: const Locale('en'),
          translations: LocaliztionApp(),
          builder: DevicePreview.appBuilder,
          darkTheme: ThemeApp.dark,
          theme: ThemeApp.light,
          initialRoute: initialRoute,
          getPages: routes,
          initialBinding: Binding(),
          debugShowCheckedModeBanner: false,
          home: SplashView()));
}
