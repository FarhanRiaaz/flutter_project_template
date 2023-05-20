// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$CategoryStore on _CategoryStore, Store {
  Computed<bool>? _$isAllCategoriesInProcessComputed;

  @override
  bool get isAllCategoriesInProcess => (_$isAllCategoriesInProcessComputed ??=
          Computed<bool>(() => super.isAllCategoriesInProcess,
              name: '_CategoryStore.isAllCategoriesInProcess'))
      .value;
  Computed<bool>? _$isCategoriesInstanceInProcessComputed;

  @override
  bool get isCategoriesInstanceInProcess =>
      (_$isCategoriesInstanceInProcessComputed ??= Computed<bool>(
              () => super.isCategoriesInstanceInProcess,
              name: '_CategoryStore.isCategoriesInstanceInProcess'))
          .value;

  late final _$allCategoryFutureAtom =
      Atom(name: '_CategoryStore.allCategoryFuture', context: context);

  @override
  ObservableFuture<AllCategoryList> get allCategoryFuture {
    _$allCategoryFutureAtom.reportRead();
    return super.allCategoryFuture;
  }

  @override
  set allCategoryFuture(ObservableFuture<AllCategoryList> value) {
    _$allCategoryFutureAtom.reportWrite(value, super.allCategoryFuture, () {
      super.allCategoryFuture = value;
    });
  }

  late final _$allCategoryInstanceFutureAtom =
      Atom(name: '_CategoryStore.allCategoryInstanceFuture', context: context);

  @override
  ObservableFuture<CategoryInstanceResponse> get allCategoryInstanceFuture {
    _$allCategoryInstanceFutureAtom.reportRead();
    return super.allCategoryInstanceFuture;
  }

  @override
  set allCategoryInstanceFuture(
      ObservableFuture<CategoryInstanceResponse> value) {
    _$allCategoryInstanceFutureAtom
        .reportWrite(value, super.allCategoryInstanceFuture, () {
      super.allCategoryInstanceFuture = value;
    });
  }

  late final _$allCategoryListAtom =
      Atom(name: '_CategoryStore.allCategoryList', context: context);

  @override
  AllCategoryList? get allCategoryList {
    _$allCategoryListAtom.reportRead();
    return super.allCategoryList;
  }

  @override
  set allCategoryList(AllCategoryList? value) {
    _$allCategoryListAtom.reportWrite(value, super.allCategoryList, () {
      super.allCategoryList = value;
    });
  }

  late final _$categoryInstanceResponseAtom =
      Atom(name: '_CategoryStore.categoryInstanceResponse', context: context);

  @override
  CategoryInstanceResponse? get categoryInstanceResponse {
    _$categoryInstanceResponseAtom.reportRead();
    return super.categoryInstanceResponse;
  }

  @override
  set categoryInstanceResponse(CategoryInstanceResponse? value) {
    _$categoryInstanceResponseAtom
        .reportWrite(value, super.categoryInstanceResponse, () {
      super.categoryInstanceResponse = value;
    });
  }

  late final _$getAllCategoriesAsyncAction =
      AsyncAction('_CategoryStore.getAllCategories', context: context);

  @override
  Future<dynamic> getAllCategories() {
    return _$getAllCategoriesAsyncAction.run(() => super.getAllCategories());
  }

  late final _$getFormByCategoryAsyncAction =
      AsyncAction('_CategoryStore.getFormByCategory', context: context);

  @override
  Future<dynamic> getFormByCategory(int catId) {
    return _$getFormByCategoryAsyncAction
        .run(() => super.getFormByCategory(catId));
  }

  @override
  String toString() {
    return '''
allCategoryFuture: ${allCategoryFuture},
allCategoryInstanceFuture: ${allCategoryInstanceFuture},
allCategoryList: ${allCategoryList},
categoryInstanceResponse: ${categoryInstanceResponse},
isAllCategoriesInProcess: ${isAllCategoriesInProcess},
isCategoriesInstanceInProcess: ${isCategoriesInstanceInProcess}
    ''';
  }
}
