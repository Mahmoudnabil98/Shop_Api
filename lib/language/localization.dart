import 'package:get/get.dart';
import 'package:shop_app/language/ar.dart';
import 'package:shop_app/language/en.dart';

class LocaliztionApp extends Translations {
  @override
  // TODO: implement keys
  Map<String, Map<String, String>> get keys => {
        "en": en,
        "ar": ar,
      };
}
