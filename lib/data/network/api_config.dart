class ApiConfig {
  ApiConfig._();

  static const baseUrl = 'https://api.yumquick.app';
  static const home = '/v1/home';
  static const categories = '/v1/categories';
  static const foods = '/v1/foods';

  static const useMock = true;
  static const simulateError = false;
  static const timeout = Duration(seconds: 10);
}