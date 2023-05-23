import 'package:dio/dio.dart';
import 'package:second_opinion_app/data/network/dio_client.dart';
import 'package:second_opinion_app/data/network/rest_client.dart';
import 'package:second_opinion_app/models/authentication/login_request.dart';
import 'package:second_opinion_app/models/authentication/login_user_response.dart';
import 'package:second_opinion_app/models/authentication/register_user_response.dart';
import 'package:second_opinion_app/models/authentication/registration_request.dart';
import 'package:second_opinion_app/models/categories/all_category_list.dart';
import 'package:second_opinion_app/models/categories/all_category_response.dart';
import 'package:second_opinion_app/models/categories/category_instance_response.dart';

import '../../constants/endpoints.dart';

class CategoryApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  CategoryApi(this._dioClient);

  /// Method to get list of categories
  ///
  Future<AllCategoryList> getAllCategories(String authToken) async {
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
        return AllCategoryList.fromJson(res);
      } else {
        throw Exception("Null response received!");
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

  /// Method to get list of categories filtered
  ///
  Future<AllCategoryList> getFilteredCategories(
      String authToken, String searchText) async {
    try {
      final res = await _dioClient.get(
        "${Endpoints.getFilteredCategories}$searchText",
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (res != null) {
        return AllCategoryList.fromJson(res);
      } else {
        throw Exception("Null response received!");
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

//todo shahzaib we need to test and add things to following method
  Future<CategoryInstanceResponse> getFormByCategory(
      String authToken, int catType) async {
    try {
      final res = await _dioClient.get(
        '${Endpoints.getFormByCatId}/$catType/',
        options: Options(
          headers: {
            'Authorization': 'Token $authToken',

          },
        ),
      );

      if (res != null) {
        return CategoryInstanceResponse.fromJson(res);
      } else {
        throw Exception("Null response received!");
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
