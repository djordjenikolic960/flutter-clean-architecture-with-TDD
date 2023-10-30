class Urls {
  static const String baseUrl = 'https://newsapi.org/v2/top-headlines';
  static const String apiKey = '7d2ed4aa0ba3486ca4eb186e7ebd1956';
  static String articlesByCategory(String category) =>
      '$baseUrl/?country=us&category=$category&apiKey=$apiKey';
}