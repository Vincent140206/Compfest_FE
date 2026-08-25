class ApiEndpoints {
  static const String register = '/api/v1/auth/register';
  static const String verify = '/api/v1/auth/verify';
  static const String login = '/api/v1/auth/login';
  static const String importStocks = '/api/v1/stocks/import';
  static const String getStocks = '/api/v1/stocks';

  static String getStockItems(String stockId) => '/api/v1/stocks/$stockId';
  static String getItemDetails(String itemId) => '/api/v1/stocks/items/$itemId';
  static String getItemDiagnose(String itemId) => '/api/v1/stocks/items/$itemId/diagnose';
  static String getStockProjections(String stockId) => '/api/v1/stocks/$stockId/projection';
}
