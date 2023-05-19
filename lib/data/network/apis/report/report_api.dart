import 'package:dio/dio.dart';
import 'package:second_opinion_app/models/report/upload_report_response.dart';

import '../../constants/endpoints.dart';
import '../../dio_client.dart';
import '../../rest_client.dart';

class ReportApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ReportApi(this._dioClient, this._restClient);



  Future<UploadReportResponse> uploadDocument(RegistrationRequest registerRequest) async {
    try {
      FormData formData = FormData.fromMap(registerRequest.toJson());

      final res = await _dioClient.post(
        Endpoints.uploadDocument,
        data: formData,
        options: Options(
          headers: {
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