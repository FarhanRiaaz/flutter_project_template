import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:mobx/mobx.dart';
part 'profile_store.g.dart';

class ProfileStore = _ProfileStore with _$ProfileStore;

abstract class _ProfileStore with Store {
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

  _ProfileStore({
    this.id = 0,
    this.name = '',
    this.email = '',
    this.profileImg = '',
    this.gender = '',
    this.age = '',
    this.weight = '',
    this.height = '',
  }) {
    fetchProfileData();
  }
}
