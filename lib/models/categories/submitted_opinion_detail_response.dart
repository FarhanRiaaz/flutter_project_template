import 'package:second_opinion_app/models/categories/category_instance_response.dart';
import 'package:second_opinion_app/models/categories/submitted_opinion_response.dart';

class SubmittedOpinionDetailResponse {
  Result? request;
  List<SubmittedUserData>? requestSubmittedUserData;

  SubmittedOpinionDetailResponse({this.request, this.requestSubmittedUserData});

  factory SubmittedOpinionDetailResponse.fromJson(Map<String, dynamic> json) {
    return SubmittedOpinionDetailResponse(
      request: json['request'] != null ? Result.fromJson(json['request']) : null,
      requestSubmittedUserData: json['request_submitted_user_data'] != null
          ? List<SubmittedUserData>.from(json['request_submitted_user_data'].map((data) => SubmittedUserData.fromJson(data)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'request': request?.toJson(),
      'request_submitted_user_data': requestSubmittedUserData != null
          ? List<dynamic>.from(requestSubmittedUserData!.map((data) => data.toJson()))
          : null,
    };
  }

  SubmittedOpinionDetailResponse copyWith({
    Result? request,
    List<SubmittedUserData>? requestSubmittedUserData,
  }) {
    return SubmittedOpinionDetailResponse(
      request: request ?? this.request,
      requestSubmittedUserData: requestSubmittedUserData ?? this.requestSubmittedUserData,
    );
  }
}


class RequestData {
  int id;
  RequestDetails request;
  String status;
  String chatRoom;
  String totalPrice;
  int totalNo;
  String paymentTransactionNo;
  DateTime createdDate;
  bool isPending;
  bool isApproved;
  bool isRunning;
  bool isComplete;
  bool isOpened;
  bool paymentCompleted;
  List<dynamic> doctors;

  RequestData({
    required this.id,
    required this.request,
    required this.status,
    required this.chatRoom,
    required this.totalPrice,
    required this.totalNo,
    required this.paymentTransactionNo,
    required this.createdDate,
    required this.isPending,
    required this.isApproved,
    required this.isRunning,
    required this.isComplete,
    required this.isOpened,
    required this.paymentCompleted,
    required this.doctors,
  });

  factory RequestData.fromJson(Map<String, dynamic> json) {
    return RequestData(
      id: json['id'],
      request: RequestDetails.fromJson(json['request']),
      status: json['status'],
      chatRoom: json['chat_room'],
      totalPrice: json['total_price'],
      totalNo: json['total_no'],
      paymentTransactionNo: json['payment_transaction_no'],
      createdDate: DateTime.parse(json['created_date']),
      isPending: json['is_pending'],
      isApproved: json['is_approved'],
      isRunning: json['is_running'],
      isComplete: json['is_complete'],
      isOpened: json['is_opened'],
      paymentCompleted: json['payment_completed'],
      doctors: List<dynamic>.from(json['doctors']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'request': request.toJson(),
      'status': status,
      'chat_room': chatRoom,
      'total_price': totalPrice,
      'total_no': totalNo,
      'payment_transaction_no': paymentTransactionNo,
      'created_date': createdDate.toIso8601String(),
      'is_pending': isPending,
      'is_approved': isApproved,
      'is_running': isRunning,
      'is_complete': isComplete,
      'is_opened': isOpened,
      'payment_completed': paymentCompleted,
      'doctors': List<dynamic>.from(doctors),
    };
  }

  RequestData copyWith({
    int? id,
    RequestDetails? request,
    String? status,
    String? chatRoom,
    String? totalPrice,
    int? totalNo,
    String? paymentTransactionNo,
    DateTime? createdDate,
    bool? isPending,
    bool? isApproved,
    bool? isRunning,
    bool? isComplete,
    bool? isOpened,
    bool? paymentCompleted,
    List<dynamic>? doctors,
  }) {
    return RequestData(
      id: id ?? this.id,
      request: request ?? this.request,
      status: status ?? this.status,
      chatRoom: chatRoom ?? this.chatRoom,
      totalPrice: totalPrice ?? this.totalPrice,
      totalNo: totalNo ?? this.totalNo,
      paymentTransactionNo: paymentTransactionNo ?? this.paymentTransactionNo,
      createdDate: createdDate ?? this.createdDate,
      isPending: isPending ?? this.isPending,
      isApproved: isApproved ?? this.isApproved,
      isRunning: isRunning ?? this.isRunning,
      isComplete: isComplete ?? this.isComplete,
      isOpened: isOpened ?? this.isOpened,
      paymentCompleted: paymentCompleted ?? this.paymentCompleted,
      doctors: doctors ?? this.doctors,
    );
  }
}

class RequestDetails {
  int id;
  Form form;
  bool isSubUser;
  int mainUser;
  int user;

  RequestDetails({
    required this.id,
    required this.form,
    required this.isSubUser,
    required this.mainUser,
    required this.user,
  });

  factory RequestDetails.fromJson(Map<String, dynamic> json) {
    return RequestDetails(
      id: json['id'],
      form: Form.fromJson(json['form']),
      isSubUser: json['is_sub_user'],
      mainUser: json['mainuser'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'form': form.toJson(),
      'is_sub_user': isSubUser,
      'mainuser': mainUser,
      'user': user,
    };
  }

  RequestDetails copyWith({
    int? id,
    Form? form,
    bool? isSubUser,
    int? mainUser,
    int? user,
  }) {
    return RequestDetails(
      id: id ?? this.id,
      form: form ?? this.form,
      isSubUser: isSubUser ?? this.isSubUser,
      mainUser: mainUser ?? this.mainUser,
      user: user ?? this.user,
    );
  }
}

class Form {
  int id;
  CategoryData category;
  String title;

  Form({
    required this.id,
    required this.category,
    required this.title,
  });

  factory Form.fromJson(Map<String, dynamic> json) {
    return Form(
      id: json['id'],
      category: CategoryData.fromJson(json['category']),
      title: json['title'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'category': category.toJson(),
      'title': title,
    };
  }

  Form copyWith({
    int? id,
    CategoryData? category,
    String? title,
  }) {
    return Form(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
    );
  }
}

class CategoryData {
  int id;
  String title;
  int price;
  String image;

  CategoryData({
    required this.id,
    required this.title,
    required this.price,
    required this.image,
  });

  factory CategoryData.fromJson(Map<String, dynamic> json) {
    return CategoryData(
      id: json['id'],
      title: json['title'],
      price: json['price'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'price': price,
      'image': image,
    };
  }

  CategoryData copyWith({
    int? id,
    String? title,
    int? price,
    String? image,
  }) {
    return CategoryData(
      id: id ?? this.id,
      title: title ?? this.title,
      price: price ?? this.price,
      image: image ?? this.image,
    );
  }
}

class SubmittedUserData {
  int id;
  Question question;
  String typeQ;
  String answer;
  int request;

  SubmittedUserData({
    required this.id,
    required this.question,
    required this.typeQ,
    required this.answer,
    required this.request,
  });

  factory SubmittedUserData.fromJson(Map<String, dynamic> json) {
    return SubmittedUserData(
      id: json['id'],
      question: Question.fromJson(json['question']),
      typeQ: json['typeQ'],
      answer: json['answer'],
      request: json['request'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'question': question.toJson(),
      'typeQ': typeQ,
      'answer': answer,
      'request': request,
    };
  }

  SubmittedUserData copyWith({
    int? id,
    Question? question,
    String? typeQ,
    String? answer,
    int? request,
  }) {
    return SubmittedUserData(
      id: id ?? this.id,
      question: question ?? this.question,
      typeQ: typeQ ?? this.typeQ,
      answer: answer ?? this.answer,
      request: request ?? this.request,
    );
  }
}
