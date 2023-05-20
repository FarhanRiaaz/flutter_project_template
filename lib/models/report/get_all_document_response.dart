import 'package:second_opinion_app/models/report/upload_report_response.dart';

class GetAllDocumentResponse {
  int? count;
  int? next;
  int? previous;
  List<Result>? results;

  GetAllDocumentResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  GetAllDocumentResponse.fromJson(Map<String, dynamic> data) {
    count = data['count'];
    next = data['next'];
    previous = data['previous'];
    results = data['results'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    data['results'] = this.results;
    return data;
  }

  factory GetAllDocumentResponse.fromMap(Map<String, dynamic> data) =>
      GetAllDocumentResponse(
        count: data['count'],
        next: data['next'],
        previous: data['previous'],
        results: data['results'],
      );

  Map<String, dynamic> toMap() => {
        'count': count,
        'next': next,
        'previous': previous,
        'results': results,
      };

  GetAllDocumentResponse copyWith({
    int? count,
    int? next,
    int? previous,
    List<Result>? results,
  }) =>
      GetAllDocumentResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );
}

class Result {
  int? id;
  String? type;
  String? fileName;
  String? file;
  User? user;
  DateTime? createdDate;

  Result({
    this.id,
    this.type,
    this.fileName,
    this.file,
    this.user,
    this.createdDate,
  });

  Result.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    user = data['user'];
    type = data['type'];
    fileName = data['fileName'];
    file = data['file'];
    createdDate = data['createdDate'];
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['user'] = this.user;
    data['type'] = this.type;
    data['fileName'] = this.fileName;
    data['file'] = this.file;
    data['createdDate'] = this.createdDate;

    return data;
  }

  factory Result.fromMap(Map<String, dynamic> data) => Result(
        id: data['id'],
        user: data['user'],
        type: data['type'],
        fileName: data['fileName'],
        file: data['file'],
        createdDate: data['createdDate'],
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'user': user,
        'type': type,
        'fileName': fileName,
        'file': file,
        'createdDate': createdDate,
      };

  Result copyWith({
    int? id,
    String? type,
    String? fileName,
    String? file,
    User? user,
    DateTime? createdDate,
  }) =>
      Result(
        id: id ?? this.id,
        type: type ?? this.type,
        fileName: fileName ?? this.fileName,
        file: file ?? this.file,
        user: user ?? this.user,
        createdDate: createdDate ?? this.createdDate,
      );
}
