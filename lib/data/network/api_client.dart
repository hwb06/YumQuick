import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/home_data.dart';
import 'api_config.dart';
import 'mock_http_client.dart';
import '../models/category.dart';
import '../models/food_summary.dart';
import '../models/food_detail.dart';

class ApiException implements Exception {
  final String message;
  ApiException(this.message);

  @override
  String toString() => message;
}

class ApiClient {
  ApiClient({http.Client? client})
      : _client = client ?? (ApiConfig.useMock ? buildMockClient() : http.Client());

  final http.Client _client;

  Future<Map<String, dynamic>> _get(String path) async {
    try {
      final res = await _client
          .get(Uri.parse('${ApiConfig.baseUrl}$path'))
          .timeout(ApiConfig.timeout);
      if (res.statusCode != 200) {
        throw ApiException('Server error (${res.statusCode})');
      }
      return jsonDecode(res.body) as Map<String, dynamic>;
    } on ApiException {
      rethrow;
    } on TimeoutException {
      throw ApiException('Request timed out');
    } catch (_) {
      throw ApiException('Something went wrong. Please try again.');
    }
  }

  Future<HomeData> fetchHome() async => HomeData.fromJson(await _get(ApiConfig.home));

  Future<List<Category>> fetchCategories() async {
    final j = await _get(ApiConfig.categories);
    return (j['categories'] as List)
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<List<FoodSummary>> fetchFoods({String? categoryId}) async {
    final q = (categoryId == null || categoryId == 'all') ? '' : '?categoryId=$categoryId';
    final j = await _get('${ApiConfig.foods}$q');
    return (j['foods'] as List)
        .map((e) => FoodSummary.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  Future<FoodDetail> fetchFoodDetail(String id) async =>
      FoodDetail.fromJson(await _get('${ApiConfig.foods}/$id'));

}