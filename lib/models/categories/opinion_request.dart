class OpinionSubmitRequest {
  int? form;
  int? userId;
  List<Answer>? answers = [];

  OpinionSubmitRequest({
    this.form,
    this.userId,
    this.answers,
  });

  OpinionSubmitRequest.fromJson(Map<String, dynamic> json) {
    form = json['form'];
    userId = json['userId'];
    if (json['answers'] != null) {
      answers = <Answer>[];
      json['answers'].forEach((v) {
        answers!.add(new Answer.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['form'] = this.form;
    if (this.userId != null) {
      data['userId'] = this.userId;
    }
    if (this.answers != null) {
      data['answers'] = this.answers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  OpinionSubmitRequest copyWith({
    int? form,
    int? userId,
    List<Answer>? answers,
  }) =>
      OpinionSubmitRequest(
        form: form ?? this.form,
        userId: userId ?? this.userId,
        answers: answers ?? this.answers,
      );
}

class Answer {
  int? question;
  String? type;
  String? answer;

  Answer({
    this.question,
    this.type,
    this.answer,
  });

  Answer.fromJson(Map<String, dynamic> json) {
    question = json['question'];
    type = json['type'];
    answer = json['answer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['question'] = this.question;
    data['type'] = this.type;
    data['answer'] = this.answer;
    return data;
  }

  Answer copyWith({
    int? question,
    String? type,
    String? answer,
  }) =>
      Answer(
        question: question ?? this.question,
        type: type ?? this.type,
        answer: answer ?? this.answer,
      );
}
