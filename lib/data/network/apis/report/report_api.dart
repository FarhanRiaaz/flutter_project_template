import '../../dio_client.dart';
import '../../rest_client.dart';

class ReportApi {
  // dio instance
  final DioClient _dioClient;

  // rest-client instance
  final RestClient _restClient;

  // injecting dio instance
  ReportApi(this._dioClient, this._restClient);

}