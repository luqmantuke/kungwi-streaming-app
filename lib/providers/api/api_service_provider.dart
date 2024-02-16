import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/services/api/api_service.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});
