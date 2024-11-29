import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fl_sevengen_society_user_app/constants/color.dart';

import 'app_utils.dart';

class NetworkUtils {
  static final NetworkUtils _networkUtils = NetworkUtils();

  static NetworkUtils get networkUtilsInstance => _networkUtils;

  final Connectivity _connectivity = Connectivity();

  // used to check connectivity status
  Future<bool> getConnectivityStatus(
 /*   AppLocalizationsData appLocalizationsData*/ {
    bool showSnackBar = true,
  }) async {
    var connectivityResult = await (_connectivity.checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile) {
      // I am connected to a mobile network.
      return true;
    } else if (connectivityResult == ConnectivityResult.wifi) {
      // I am connected to a wifi network.
      return true;
    } else {
      if (showSnackBar) {
        AppUtils.appUtilsInstance.showSnackBar(
           /* appLocalizationsData.common.text.network*/"Network", /*appLocalizationsData.common.text.checkInternetConnection*/"Please check your internet connection",
            backgroundColor: colorRed);
      }
      return false;
    }
  }
}
