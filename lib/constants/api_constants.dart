abstract final class ApiCons {
  static String photoPath() => '/search/photos';

  static Map<String, String> photoParams({
    required String page,
    required String query,
  }) =>
      {
        "page": page,
        "query": query,
      };
}
