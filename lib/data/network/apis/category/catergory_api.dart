import 'package:dio/dio.dart';
import 'package:second_opinion_app/data/network/dio_client.dart';
import 'package:second_opinion_app/models/categories/all_category_list.dart';
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

  ///Method to submit second opinion
  Future<OpinionSubmitResponse> submitSecondOpinion(SubProfileRequest request, String token) async {
    try {
      FormData formData = FormData.fromMap({
        'name': request.name,
        'gender': request.gender,
        'age': request.age,
        'weight': request.weight,
        'color': request.color,
        'height': request.height,
        'height_unit':request.heightUnit,
        'weight_unit':request.weightUnit,
        if (request.profileImg?.path != null)
          'profileImg': await MultipartFile.fromFile(request.profileImg!.path   ),
      });
      print(formData.fields);
      final res = await _dioClient.post(
        Endpoints.subProfile,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );
      if (res != null) {
        return SubProfileResponse.fromJson(res);
      } else {
        print("Null response received!\naddSubUserProfile()");
        return SubProfileResponse();
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }



}
