import 'package:url_launcher/url_launcher_string.dart';

class Utility {
  static Future<void> openUrl(
      String url) async {
    if (await canLaunchUrlString(url)) {
      await launchUrlString(url);
    }
  }

  static Future<void> openMail() =>
      openUrl(
          "mailto:sree2visakh@gmail.com");

  static Future<void>
      openMyLocation() => openUrl(
          "https://maps.app.goo.gl/jnMkTf6tn3aBN55R9");

  static Future<void> openMyPhonNo() =>
      openUrl("tel:+91-8075600484");

  static Future<void> openWhatsapp() =>
      openUrl(
          "https://wa.me/8075600484");
}
