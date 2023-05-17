import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import '../../data/repository/repository.dart';
import '../../models/profile/profile_response.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final Repository _repository;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<ProfileResponse> emptyProfileResponse =
  ObservableFuture.value(ProfileResponse());

  @observable
  ObservableFuture<ProfileResponse> profileFuture = emptyProfileResponse;

  @observable
  ProfileResponse? currentUserProfile;

  @computed
  bool get isProfileInProcess => profileFuture.status == FutureStatus.pending;

  @action
  Future getProfile() async {
    final future = _repository.getProfile();
     profileFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.id != null) {
        currentUserProfile = value;
      } else {
        print('failed to login\nInvalid creds are provided!');
      }
    }).catchError((e) {
      print(e);

      print('failed to login\nInvalid creds are provided!\n${e.toString()}');
      throw e;
    });
  }

  _ProfileStore(
    Repository repository,
  ) : this._repository = repository {}
}
