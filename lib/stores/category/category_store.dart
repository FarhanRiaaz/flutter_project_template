import 'package:mobx/mobx.dart';
import 'package:second_opinion_app/models/categories/all_category_list.dart';
import 'package:second_opinion_app/models/categories/category_instance_response.dart';

import '../../data/repository/category_repository.dart';

part 'category_store.g.dart';

class CategoryStore = _CategoryStore with _$CategoryStore;

abstract class _CategoryStore with Store {
  final CategoryRepository _categoryRepository;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<AllCategoryList> emptyGetAllCategoryResponse =
      ObservableFuture.value(AllCategoryList());

  static ObservableFuture<CategoryInstanceResponse>
      emptyCategoryInstanceResponse =
      ObservableFuture.value(CategoryInstanceResponse());

  @observable
  ObservableFuture<AllCategoryList> allCategoryFuture =
      emptyGetAllCategoryResponse;
  @observable
  ObservableFuture<CategoryInstanceResponse> allCategoryInstanceFuture =
      emptyCategoryInstanceResponse;

  @observable
  AllCategoryList? allCategoryList;

  @observable
  CategoryInstanceResponse? categoryInstanceResponse;

  @computed
  bool get isAllCategoriesInProcess =>
      allCategoryFuture.status == FutureStatus.pending;

  @computed
  bool get isCategoriesInstanceInProcess =>
      allCategoryInstanceFuture.status == FutureStatus.pending;

  @action
  Future getAllCategories() async {
    final future = _categoryRepository.getAllCategories();
    allCategoryFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.allCategoryList != null) {
        allCategoryList = value;
      } else {
        print('failed to getAllCategories\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print(
          'failed to getAllCategories\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  @action
  Future getFormByCategory() async {
    final future = _categoryRepository.getFormByCategory();
    allCategoryInstanceFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value != null) {
        categoryInstanceResponse = value;
      } else {
        print('failed to getFormByCategory\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print(
          'failed to getFormByCategory\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  _CategoryStore(
    CategoryRepository categoryRepository,
  ) : this._categoryRepository = categoryRepository {}
}
