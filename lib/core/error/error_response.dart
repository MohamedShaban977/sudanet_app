class ErrorUnauthorizedResponse {
  ErrorUnauthorizedResponse({
    this.detail,
  });

  final String? detail;

  factory ErrorUnauthorizedResponse.fromJson(Map<String, dynamic> json) =>
      ErrorUnauthorizedResponse(
        detail: json["detail"],
      );
}

class ErrorBadRequestResponse {
  ErrorBadRequestResponse({
    this.password,
    this.username,
  });

  final List<String>? password;
  final List<String>? username;

  factory ErrorBadRequestResponse.fromJson(Map<String, dynamic> json) =>
      ErrorBadRequestResponse(
        password: json["password"] == null
            ? []
            : List<String>.from(json["password"]!.map((x) => x)),
        username: json["username"] == null
            ? []
            : List<String>.from(json["username"]!.map((x) => x)),
      );
}
