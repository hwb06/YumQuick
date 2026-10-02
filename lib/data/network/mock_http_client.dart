import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'api_config.dart';
import 'mock_food_data.dart';

const _json = {'content-type': 'application/json; charset=utf-8'};

MockClient buildMockClient() {
  return MockClient((request) async {
    await Future.delayed(const Duration(milliseconds: 700));

    if (ApiConfig.simulateError) {
      return http.Response(jsonEncode({'message': 'Server error'}), 500, headers: _json);
    }

    final path = request.url.path;
    if (request.method == 'GET') {
      if (path == ApiConfig.home) {
        return http.Response(jsonEncode(MockFoodData.home), 200, headers: _json);
      }
      if (path == ApiConfig.categories) {
        return http.Response(
            jsonEncode({'categories': MockFoodData.home['categories']}), 200, headers: _json);
      }
      if (path == ApiConfig.foods) {
        final cat = request.url.queryParameters['categoryId'];
        final list = MockFoodData.allFoods
            .where((f) => cat == null || cat.isEmpty || f['categoryId'] == cat)
            .toList();
        return http.Response(jsonEncode({'foods': list}), 200, headers: _json);
      }
      if (path.startsWith('${ApiConfig.foods}/')) {
        final d = MockFoodData.detail(path.split('/').last);
        if (d != null) return http.Response(jsonEncode(d), 200, headers: _json);
      }
    }
    return http.Response(jsonEncode({'message': 'Not found'}), 404, headers: _json);
  });
}