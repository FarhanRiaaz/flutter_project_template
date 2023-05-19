import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:second_opinion_app/data/repository/report_repository.dart';
import 'package:second_opinion_app/models/report/upload_report_response.dart';

part 'report_store.g.dart';

class ReportStore = _ReportStore with _$ReportStore;

abstract class _ReportStore with Store {
  final ReportRepository _reportRepository;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<UploadReportResponse> emptyUploadReportResponse =
      ObservableFuture.value(UploadReportResponse());

  @observable
  ObservableFuture<UploadReportResponse> reportFuture =
      emptyUploadReportResponse;

  @observable
  UploadReportResponse? currentReportResponse;

  @observable
  String? fileName;
  @observable
  String? fileType;
  @observable
  File? documentFile;
  @observable
  int? userId;

  @computed
  bool get isUploadInProcess => reportFuture.status == FutureStatus.pending;

  @action
  Future uploadReport() async {
    final future = _reportRepository.uploadDocument(
        fileName!, fileType!, documentFile!, userId!);
    reportFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.id != null) {
        currentReportResponse = value;
      } else {
        print('failed to uploadReport\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print('failed to uploadReport\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  _ReportStore(
    ReportRepository reportRepository,
  ) : this._reportRepository = reportRepository {}
}
