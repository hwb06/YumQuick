class ApiConfig {
  ApiConfig._();

  static const baseUrl = 'https://api.yumquick.app';
  static const home = '/v1/home';
  static const categories = '/v1/categories';
  static const foods = '/v1/foods';

  static const useMock = true;          // real API aane par false
  static const simulateError = false;   // true karke ErrorView test karein
  static const timeout = Duration(seconds: 10);
}