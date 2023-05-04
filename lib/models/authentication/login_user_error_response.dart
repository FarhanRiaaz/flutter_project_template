class LoginUserErrorResponse {
  final String? error;

  LoginUserErrorResponse({
    this.error,
  });

  factory LoginUserErrorResponse.fromMap(Map<String, dynamic> json) =>
      LoginUserErrorResponse(
        error: json["error"],
      );

  Map<String, dynamic> toMap() => {
        "error": error,
      };

  LoginUserErrorResponse copyWith({
    String? error,
  }) =>
      LoginUserErrorResponse(
        error: error ?? this.error,
      );
}
