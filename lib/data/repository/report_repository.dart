import 'dart:io';

import 'package:second_opinion_app/models/report/upload_report_response.dart';

import '../network/apis/report/report_api.dart';
import '../sharedpref/shared_preference_helper.dart';

class ReportRepository {
  // api objects
  final ReportApi _reportApi;

  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  ReportRepository(this._reportApi, this._sharedPrefsHelper);

  Future<UploadReportResponse> uploadDocument(
    String fileName,
    String fileType,
    File documentFile,
    int userId,
  ) async {
    final authToken = await _sharedPrefsHelper.authToken;
    print("uploadReport$authToken");
    return await _reportApi.uploadDocument(
        fileName, fileType, documentFile, userId, authToken!);
  }

  Future<String?> get authToken async => await _sharedPrefsHelper.authToken;
}
