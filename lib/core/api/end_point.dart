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
      '${baseUrl}Course/GetByCategoryId?CategoryId=';

  static const String getPublicCourseDetail =
      '${baseUrl}Course/GetPublicCourseDetail?Id=';

  static const String getAllCategory = '${baseUrl}Category/Get';

//
  static const String getContactInfo = '${baseUrl}ContactInfo/Get';
//
// static const String categories = '${baseUrl}api/v1/categories/';
//
// static const String productsByCategoryById =
//     '${baseUrl}api/v1/products/category/';
}
