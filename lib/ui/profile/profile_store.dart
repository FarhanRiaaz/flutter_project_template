import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';

import '../../data/repository/repository.dart';
import '../../models/profile/profile_response.dart';

part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
  final Repository _repository;

  @observable
  ProfileResponse? currentUserProfile;

  @observable
  int id;

  @observable
  String name;

  @observable
  String email;

  @observable
  String profileImg;

  @observable
  String gender;

  @observable
  String age;

  @observable
  String weight;

  @observable
  String height;

  @action
  Future<void> fetchProfileData() async {
    final response = await http.get(Uri.parse('https://sop.zpexsolutions.com/patient-app/api/profile'));
    print('object');
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      id = data['id'];
      name = data['user']['name'];
      email = data['user']['email'];
      profileImg = data['profileImg'];
      gender = data['gender'];
      age = data['age'];
      weight = data['weight'];
      height = data['height'];
    } else {
      throw Exception('Failed to fetch profile data');
    }
  }

  @action
  Future getProfile() async {
    final future =  _repository.getProfile();
    final loginFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.id != null) {
        currentUserProfile=value;
        // saving informtion here
        // this.id = value.id??0;
        // this.height = value.height??"";
        // this.name = value.name??"";
        // this.age = value.age!;
        // this.email = value.email??"";
        // this.profileImg = value.profileImg??"";
        // this.gender = value.gender??"";
        // this.weight = value.weight??"";
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
    Repository repository, {
    this.id = 0,
    this.name = '',
    this.email = '',
    this.profileImg = '',
    this.gender = '',
    this.age = '',
    this.weight = '',
    this.height = '',
  }) : this._repository = repository {
   // fetchProfileData();
  }
}
