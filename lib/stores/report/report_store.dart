import 'package:mobx/mobx.dart';
import 'package:second_opinion_app/data/repository/report_repository.dart';

part 'report_store.g.dart';

class ReportStore = _ReportStore with _$ReportStore;

abstract class _ReportStore with Store {
  final ReportRepository _reportRepository;

  _ReportStore(
      ReportRepository reportRepository,
      ) : this._reportRepository = reportRepository {}
}