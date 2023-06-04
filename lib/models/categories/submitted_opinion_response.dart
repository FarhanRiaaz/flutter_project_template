class SecondOpinionSubmittedResponse {
  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  SecondOpinionSubmittedResponse({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  SecondOpinionSubmittedResponse.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    previous = json['previous'];
    if (json['results'] != null) {
      results = <Result>[];
      json['results'].forEach((v) {
        results!.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['next'] = this.next;
    data['previous'] = this.previous;
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  SecondOpinionSubmittedResponse copyWith({
    int? count,
    dynamic next,
    dynamic previous,
    List<Result>? results,
  }) =>
      SecondOpinionSubmittedResponse(
        count: count ?? this.count,
        next: next ?? this.next,
        previous: previous ?? this.previous,
        results: results ?? this.results,
      );
}

class Result {
  int? id;
  Form? form;
  bool? isSubUser;
  String? status;
  bool? paymentCompleted;
  String? createDate;
  bool? isPending;
  bool? isApproved;
  bool? isRuning;
  bool? isComplete;
  int? mainuser;
  int? user;

  Result({
    this.id,
    this.form,
    this.isSubUser,
    this.status,
    this.paymentCompleted,
    this.createDate,
    this.isPending,
    this.isApproved,
    this.isRuning,
    this.isComplete,
    this.mainuser,
    this.user,
  });

  Result.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    form = json['form'] != null ? new Form.fromJson(json['form']) : null;
    isSubUser = json['is_sub_user'];
    status = json['status'];
    paymentCompleted = json['payment_completed'];
    createDate = json['create_date'];
    isPending = json['is_pending'];
    isApproved = json['is_approved'];
    isRuning = json['is_runing'];
    isComplete = json['is_complete'];
    mainuser = json['mainuser'];
    user = json['user'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.form != null) {
      data['form'] = this.form!.toJson();
    }
    data['is_sub_user'] = this.isSubUser;
    data['status'] = this.status;
    data['payment_completed'] = this.paymentCompleted;
    data['create_date'] = this.createDate;
    data['is_pending'] = this.isPending;
    data['is_approved'] = this.isApproved;
    data['is_runing'] = this.isRuning;
    data['is_complete'] = this.isComplete;
    data['mainuser'] = this.mainuser;
    data['user'] = this.user;
    return data;
  }

  Result copyWith({
    int? id,
    Form? form,
    bool? isSubUser,
    String? status,
    bool? paymentCompleted,
    String? createDate,
    bool? isPending,
    bool? isApproved,
    bool? isRuning,
    bool? isComplete,
    int? mainuser,
    int? user,
  }) =>
      Result(
        id: id ?? this.id,
        form: form ?? this.form,
        isSubUser: isSubUser ?? this.isSubUser,
        status: status ?? this.status,
        paymentCompleted: paymentCompleted ?? this.paymentCompleted,
        createDate: createDate ?? this.createDate,
        isPending: isPending ?? this.isPending,
        isApproved: isApproved ?? this.isApproved,
        isRuning: isRuning ?? this.isRuning,
        isComplete: isComplete ?? this.isComplete,
        mainuser: mainuser ?? this.mainuser,
        user: user ?? this.user,
      );
}

class Form {
  int? id;
  Category? category;
  String? title;

  Form({
    this.id,
    this.category,
    this.title,
  });

  Form.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    category = json['category'] != null
        ? new Category.fromJson(json['category'])
        : null;
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.category != null) {
      data['category'] = this.category!.toJson();
    }
    data['title'] = this.title;
    return data;
  }

  Form copyWith({
    int? id,
    Category? category,
    String? title,
  }) =>
      Form(
        id: id ?? this.id,
        category: category ?? this.category,
        title: title ?? this.title,
      );
}

class Category {
  int? id;
  String? title;
  int? price;
  String? image;

  Category({
    this.id,
    this.title,
    this.price,
    this.image,
  });

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['price'] = this.price;
    data['image'] = this.image;
    return data;
  }

  Category copyWith({
    int? id,
    String? title,
    int? price,
    String? image,
  }) =>
      Category(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        image: image ?? this.image,
      );
}





