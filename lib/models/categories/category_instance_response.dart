class CategoryInstanceResponse {
  int? id;
  int? category;
  String? title;
  List<Question>? questions;

  CategoryInstanceResponse({
    this.id,
    this.category,
    this.title,
    this.questions,
  });

  CategoryInstanceResponse.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    title = data['title'];
    category = data['category'];
    questions = data['questions'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['title'] = this.title;
    data['category'] = this.category;
    data['questions'] = this.questions;
    return data;
  }

  CategoryInstanceResponse copyWith({
    int? id,
    int? category,
    String? title,
    List<Question>? questions,
  }) =>
      CategoryInstanceResponse(
        id: id ?? this.id,
        category: category ?? this.category,
        title: title ?? this.title,
        questions: questions ?? this.questions,
      );
}

class Question {
  int? id;
  String? type;
  String? question;
  List<Option>? options;

  Question({
    this.id,
    this.type,
    this.question,
    this.options,
  });

  Question.fromJson(Map<String, dynamic> data) {
    id = data['id'];
    type = data['type'];
    options = data['options'];
    question = data['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['id'] = this.id;
    data['type'] = this.type;
    data['options'] = this.options;
    data['question'] = this.question;
    return data;
  }

  Question copyWith({
    int? id,
    String? type,
    String? question,
    List<Option>? options,
  }) =>
      Question(
        id: id ?? this.id,
        type: type ?? this.type,
        question: question ?? this.question,
        options: options ?? this.options,
      );
}

class Option {
  String? option;
  int? question;

  Option({
    this.option,
    this.question,
  });

  Option.fromJson(Map<String, dynamic> data) {
    option = data['option'];
    question = data['question'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['option'] = this.option;
    data['question'] = this.question;
    return data;
  }

  Option copyWith({
    String? option,
    int? question,
  }) =>
      Option(
        option: option ?? this.option,
        question: question ?? this.question,
      );
}
