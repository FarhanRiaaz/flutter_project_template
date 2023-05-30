import 'dart:io';

import 'package:mobx/mobx.dart';
import 'package:second_opinion_app/data/repository/report_repository.dart';
import 'package:second_opinion_app/models/report/get_all_document_response.dart';
import 'package:second_opinion_app/models/report/upload_report_response.dart';

part 'report_store.g.dart';

class ReportStore = _ReportStore with _$ReportStore;

abstract class _ReportStore with Store {
  final ReportRepository _reportRepository;

  // empty responses:-----------------------------------------------------------
  static ObservableFuture<UploadReportResponse> emptyUploadReportResponse = ObservableFuture.value(UploadReportResponse());

  static ObservableFuture<GetAllDocumentResponse> emptyGetAllDocumentResponse = ObservableFuture.value(GetAllDocumentResponse());

  static ObservableFuture<bool> emptyDeleteDocumentResponse = ObservableFuture.value(false);

  @observable
  ObservableFuture<UploadReportResponse> reportFuture = emptyUploadReportResponse;

  @observable
  ObservableFuture<bool> deleteDocumentFuture = emptyDeleteDocumentResponse;

  @observable
  ObservableFuture<GetAllDocumentResponse> getAllDocumentResponseFuture = emptyGetAllDocumentResponse;

  @observable
  UploadReportResponse? currentReportResponse;

  @observable
  GetAllDocumentResponse? getAllDocumentResponseList;

  @observable
  int? currentDocumentToDelete;

  @observable
  bool? isDocumentDeleted = false;

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

  @computed
  bool get isDeletedInProcess => deleteDocumentFuture.status == FutureStatus.pending;

  @computed
  bool get isFetchDocumentInProcess => getAllDocumentResponseFuture.status == FutureStatus.pending;

  /// method to uploadReport via api fill the fields  and check the response of currentReportResponse
  @action
  Future uploadReport() async {
    final future = _reportRepository.uploadDocument(fileName!, fileType!, documentFile!, userId!);
    reportFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.id != null) {
        currentReportResponse = value;
       await getAllDocumentList();
      } else {
        print('failed to uploadReport\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print('failed to uploadReport\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  /// method to get all document via api just run and check the response of getAllDocumentResponseList
  @action
  Future getAllDocumentList() async {
    final future = _reportRepository.getAllDocumentList();
    getAllDocumentResponseFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.count != null) {
        getAllDocumentResponseList = value;
      } else {
        print('failed to getAllDocumentList\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print('failed to getAllDocumentList\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  /// method to get filtered document via api just pass the args and check the response of getAllDocumentResponseList
  @action
  Future getFilteredDocumentList(String sortFilter, String userName, String reportType) async {
    //Todo implement
    final future = _reportRepository.getFilteredDocumentList(sortFilter, userName, reportType);
    getAllDocumentResponseFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value.count != null) {
        getAllDocumentResponseList = value;
      } else {
        print('failed to getFilteredDocumentList\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print('failed to getFilteredDocumentList\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  /// method to delete document via api just pass the document id currentDocumentToDelete just check the response of isDocumentDeleted
  @action
  Future deleteDocument() async {
    final future = _reportRepository.deleteDocument(currentDocumentToDelete ?? 0);
    deleteDocumentFuture = ObservableFuture(future);
    await future.then((value) async {
      if (value) {
        isDocumentDeleted = value;
        getAllDocumentList();
      } else {
        print('failed to deleteDocument\nSomething went wrong');
      }
    }).catchError((e) {
      print(e);

      print('failed to deleteDocument\nSomething went wrong!\n${e.toString()}');
      throw e;
    });
  }

  _ReportStore(
    ReportRepository reportRepository,
  ) : this._reportRepository = reportRepository {}
}
