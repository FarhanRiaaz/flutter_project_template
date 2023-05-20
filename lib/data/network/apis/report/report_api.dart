import 'dart:io';

import 'package:dio/dio.dart';
import 'package:second_opinion_app/models/report/upload_report_response.dart';

import '../../constants/endpoints.dart';
import '../../dio_client.dart';
import '../../rest_client.dart';

class ReportApi {
  // dio instance
  final DioClient _dioClient;

  // injecting dio instance
  ReportApi(this._dioClient);

  Future<UploadReportResponse> uploadDocument(String fileName, String fileType,
      File documentFile, int userId, String token) async {
    try {
      FormData formData = FormData.fromMap({
        'fileName': fileName,
        'type': fileType,
        'file':
            await MultipartFile.fromFile(documentFile.path, filename: fileName),
        'userId': userId,
      });

      final res = await _dioClient.post(
        Endpoints.documents,
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Token $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (res != null) {
        return UploadReportResponse.fromJson(res);
      } else {
        throw Exception("Null response received!");
      }
    } catch (e) {
      print(e.toString());
      throw e;
    }
  }
}
