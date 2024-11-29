import 'package:url_launcher/url_launcher.dart';

class LauncherUtils {
  static final LauncherUtils _launcherUtils = LauncherUtils();

  static LauncherUtils get launcherUtilsInstance => _launcherUtils;

  //launch url in Browser
  Future<bool> launchInBrowser({String? url, Map<String, String>? headers}) async {
    if (await canLaunch(url!)) {
      return await launch(
        url,
        forceSafariVC: false,
        forceWebView: false,
        headers: headers ?? {},
      );
    } else {
      return false;
    }
  }

  //method to make phone call
  Future<bool> makePhoneCall({String? phoneNumber}) async {
    if (await canLaunch("tel:$phoneNumber")) {
      return await launch("tel:$phoneNumber");
    } else {
      return false;
    }
  }

  //method used to open email
  Future<bool> launchEmail({String? email, String subject = "", String body = ""}) async {
    String params = Uri(
      scheme: 'mailto',
      path: email,
      query: 'subject=$subject&body=$body', //add subject and body here
    ).toString();
    if (await canLaunch(params)) {
      return await launch(params);
    } else {
      return false;
    }
  }
}
