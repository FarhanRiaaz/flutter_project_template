import 'package:second_opinion_app/data/network/apis/category/catergory_api.dart';
import 'package:second_opinion_app/models/categories/all_category_list.dart';
import 'package:second_opinion_app/models/categories/all_category_response.dart';
import 'package:second_opinion_app/models/categories/category_instance_response.dart';

import '../sharedpref/shared_preference_helper.dart';

class CategoryRepository {
  // api objects
  final CategoryApi _categoryApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  CategoryRepository(this._categoryApi, this._sharedPrefsHelper);

  Future<AllCategoryList> getAllCategories() async {
    final authToken = await _sharedPrefsHelper.authToken;
    print("getAllCategories$authToken");
    return await _categoryApi.getAllCategories(authToken!);
  }

  Future<AllCategoryList> getFilteredCategories(String searchString) async {
    final authToken = await _sharedPrefsHelper.authToken;
    print("getFilteredCategories$authToken");
    return await _categoryApi.getFilteredCategories(authToken!,searchString);
  }

  Future<CategoryInstanceResponse> getFormByCategory(int catType) async {
    final authToken = await _sharedPrefsHelper.authToken;
    print("getFormByCategory$authToken");
    return await _categoryApi.getFormByCategory(authToken!, catType);
  }

  Future<String?> get authToken async => await _sharedPrefsHelper.authToken;
}
