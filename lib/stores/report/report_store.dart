import 'package:mobx/mobx.dart';
import '../../data/repository/repository.dart';

part 'report_store.g.dart';

class ReportStore = _ReportStore with _$ReportStore;

abstract class _ReportStore with Store {
  final Repository _repository;

  _ReportStore(
      Repository repository,
      ) : this._repository = repository {}
}