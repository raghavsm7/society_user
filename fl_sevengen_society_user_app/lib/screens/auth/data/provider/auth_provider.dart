import 'package:fl_sevengen_society_user_app/common/data/model/common_response_model.dart';
import 'package:fl_sevengen_society_user_app/constants/end_point_constants.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';
import 'package:fl_sevengen_society_user_app/service/api.dart';

class AuthProvider extends ApiServiceProvider {
  //api call send OTP
  Future<dynamic> callSendOTPApi({
    String? phoneNumber,
  }) async {
    var result = await postMethod(
      sendOtp,
      {
        "mobile_number": "+91$phoneNumber",
      },
      forNullData: true,
    );
    return result;
  }

//api call verify OTP
  Future<dynamic> callVerifyOTPApi({String? phoneNumber, String? otp}) async {
    var result = await postMethod(
      verifyOtp,
      {"mobile_number": "+91$phoneNumber", "otp_code": otp},
      forNullData: true,
    );
    return result;
  }

  //api to call register user
  Future<dynamic> callRegisterApi(
      {String? phoneNumber,
      String? username,
      String? flatNumber,
      String? societyCode,
      String? password}) async {
    var result = await postMethod(
      register,
      {
        "mobile_number": "+91$phoneNumber",
        "society_code": societyCode,
        "name": username,
        "flat_no": flatNumber,
        "password": password
      },
      forNullData: false,
    );
    if (result is CommonResponseModel) {
      return result;
    } else {
      return AuthResponseModel.fromJson(result);
    }
  }

  Future<dynamic> callLogInApi({String? phoneNumber, String? password}) async {
    var result = await postMethod(
      login,
      {"mobile_number": "+91$phoneNumber", "password": password},
      forNullData: false,
    );
    if (result is CommonResponseModel) {
      return result;
    } else {
      return AuthResponseModel.fromJson(result);
    }
  }

  Future<dynamic> callIsUserVerifiedOrNot() async {
    var result = await getMethod(
      isUserVerified,
    );
    if (result is CommonResponseModel) {
      return result;
    } else {
      return AuthResponseModel.fromJson(result);
    }
  }
}
