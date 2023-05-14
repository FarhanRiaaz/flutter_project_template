class Endpoints {
  Endpoints._();

  // base url
  static const String baseUrl = "https://sop.zpexsolutions.com/patient-app/api";

  // receiveTimeout
  static const Duration receiveTimeout = Duration(milliseconds: 15000);

  // connectTimeout
  static const Duration connectionTimeout = Duration(milliseconds: 30000);

  // booking endpoints
  static const String register = baseUrl + "/register";
  static const String login = baseUrl + "/login";
  static const String logout = baseUrl + "/logout";
  static const String profile = baseUrl + "/profile";
}
