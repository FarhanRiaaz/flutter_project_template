import 'package:dio/dio.dart';
import 'package:second_opinion_app/data/network/dio_client.dart';
import 'package:second_opinion_app/data/network/rest_client.dart';
import 'package:second_opinion_app/models/authentication/login_request.dart';
import 'package:second_opinion_app/models/authentication/login_user_response.dart';
import 'package:second_opinion_app/models/authentication/register_user_response.dart';
import 'package:second_opinion_app/models/authentication/registration_request.dart';

import '../../constants/endpoints.dart';

class CategoryApi {
  // dio instance
  final DioClient _dioClient;


  // injecting dio instance
  CategoryApi(this._dioClient);

  /// Method to get list of categories
  ///
  Future<RegisterUserResponse> getALlCategories(String authToken) async {
    try {

      final res = await _dioClient.get(
        Endpoints.getCategories,
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (res != null) {
        return RegisterUserResponse.fromJson(res);
      } else {
        throw Exception("Null response received!");
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}
