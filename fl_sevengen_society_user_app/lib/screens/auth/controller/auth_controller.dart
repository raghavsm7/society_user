import 'package:fl_sevengen_society_user_app/controller/base_controller.dart';
import 'package:fl_sevengen_society_user_app/screens/auth/data/model/auth_response_model.dart';

class AuthController extends BaseController {
  AuthResponseModel? authResponseModel;


  // used to get API url
  getApiUrl() {
    return "https://gate.prettybro.com/api/";
  }
}
