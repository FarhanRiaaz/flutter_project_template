import 'package:second_opinion_app/data/network/dio_client.dart';
import 'package:second_opinion_app/data/network/rest_client.dart';
import 'package:second_opinion_app/models/authentication/login_user_response.dart';
import 'package:second_opinion_app/models/authentication/register_user_response.dart';

import '../../constants/endpoints.dart';

class AuthenticationApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  AuthenticationApi(this._dioClient, this._restClient);

  /// Method to registerUser it will return with a complete model or with a single item
  Future<RegisterUserResponse> registerUser() async {
    try {
      final res = await _dioClient.get(Endpoints.register);
      if (res != null && RegisterUserResponse.fromJson(res).name != null) {
        return RegisterUserResponse.fromJson(res);
      } else {
        print("Null response received!\nregisterUser()");
        return RegisterUserResponse();
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// method to login user it will respond with token otherwise with an error
  Future<LoginUserResponse> loginUser() async {
    try {
      final res = await _dioClient.get(Endpoints.login);
      if (res != null) {
        return LoginUserResponse.fromJson(res);
      } else {
        throw Future.error(Exception("Null response received!\loginUser()"));
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
