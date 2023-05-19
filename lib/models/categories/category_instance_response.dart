class CategoryInstanceResponse {
  final int? id;
  final int? category;
  final String? title;
  final List<Question>? questions;

  CategoryInstanceResponse({
    this.id,
    this.category,
    this.title,
    this.questions,
  });

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
  final int? id;
  final String? type;
  final String? question;
  final List<Option>? options;

  Question({
    this.id,
    this.type,
    this.question,
    this.options,
  });

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
  final String? option;
  final int? question;

  Option({
    this.option,
    this.question,
  });

  Option copyWith({
    String? option,
    int? question,
  }) =>
      Option(
        option: option ?? this.option,
        question: question ?? this.question,
      );
}
