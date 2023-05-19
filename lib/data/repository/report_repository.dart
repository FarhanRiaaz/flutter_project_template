import '../network/apis/report/report_api.dart';
import '../sharedpref/shared_preference_helper.dart';

class ReportRepository {
  // api objects
  final ReportApi _reportApi;


  // shared pref object
  final SharedPreferenceHelper _sharedPrefsHelper;

  // constructor
  ReportRepository(this._reportApi, this._sharedPrefsHelper);
}