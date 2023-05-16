import 'dart:io';

import 'package:dio/dio.dart';

import '../../../../models/profile/profile_response.dart';
import '../../constants/endpoints.dart';
import '../../dio_client.dart';

class ProfileApi {
  // Dio instance
  final DioClient _dioClient;

  // Injecting Dio instance
  ProfileApi(this._dioClient);

  /// Method to get user profile
  Future<ProfileResponse> getUserProfile(String token) async {
    try {
      final res = await _dioClient.get(
        Endpoints.profile,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );
      if (res != null) {
        return ProfileResponse.fromJson(res);
      } else {
        print("Null response received!\ngetUserProfile()");
        return ProfileResponse();
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }

}
