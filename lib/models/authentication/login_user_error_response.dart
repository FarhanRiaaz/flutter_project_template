class LoginUserErrorResponse {
  final String? error;

  LoginUserErrorResponse({
    this.error,
  });

  LoginUserErrorResponse copyWith({
    String? error,
  }) =>
      LoginUserErrorResponse(
        error: error ?? this.error,
      );
}
