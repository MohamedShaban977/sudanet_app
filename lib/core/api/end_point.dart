class EndPoint {
  /// base Url

  static const String baseUrl = 'https://suda-net.com/api/';

  /// end Point Authentication
  static const String login = '${baseUrl}Account/Login';
  static const String register = '${baseUrl}Account/Register';
  static const String resetPassword = '${baseUrl}Account/ResetPassword';

  /// end Point Home
  static const String getSliders = '${baseUrl}Home/GetSliders';
  static const String getCategories = '${baseUrl}Home/GetCategories';
  static const String getCourses = '${baseUrl}Home/GetCourses';

  static const String getCoursesByCategoriesId =
      '${baseUrl}Course/GetByCategoryId';

  static const String getPublicCourseDetail =
      '${baseUrl}Course/GetPublicCourseDetail';
  static const String getAuthCourseDetail =
      '${baseUrl}Course/GetAuthCourseDetail';

  static const String getFreeCourseLecture =
      '${baseUrl}Lecture/GetFreeCourseLecture';
  static const String getAuthCourseLecture =
      '${baseUrl}Lecture/GetAuthCourseLecture';

  static const String buyCourse = '${baseUrl}Course/BuyCourse';

  static const String getAllCategory = '${baseUrl}Category/Get';

  static const String getContactInfo = '${baseUrl}ContactInfo/Get';
  static const String getUserPersonalInfo =
      '${baseUrl}Profile/GetUserPersonalInfo';
  static const String saveUserPersonalInfo =
      '${baseUrl}Profile/SaveUserPersonalInfo';

  static const String changePassword = '${baseUrl}Profile/ChangePassword';
  static const String getUserCourses = '${baseUrl}Profile/GetUserCourses';

  static const String getExamReady = '${baseUrl}Exam/GetExamReady';
  static const String getExam = '${baseUrl}Exam/GetExam';
  static const String saveAnswer = '${baseUrl}Exam/SaveAnswer';
  static const String endExam = '${baseUrl}Exam/EndExam';
}
