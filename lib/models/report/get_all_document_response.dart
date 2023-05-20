import 'package:second_opinion_app/models/report/upload_report_response.dart';

class GetAllDocumentResponse {
  final List<UploadReportResponse>? getAllDocResponses;

  GetAllDocumentResponse({
    this.getAllDocResponses,
  });

  factory GetAllDocumentResponse.fromJson(List<dynamic> json) {
    List<UploadReportResponse> getAllDocResponse = <UploadReportResponse>[];
    getAllDocResponse =
        json.map((document) => UploadReportResponse.fromMap(document)).toList();

    return GetAllDocumentResponse(
      getAllDocResponses: getAllDocResponse,
    );
  }
}
