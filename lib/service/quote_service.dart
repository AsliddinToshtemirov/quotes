import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes/models/quote_model.dart';
import 'package:quotes/service/base_service.dart';

class QuoteService extends BaseService {
  Dio dio = Dio();
  final baseUrl = "https://api.quotable.io/random";
  @override
  Future<Quotes> getResponse() async {
    try {
      var response = await dio.get(baseUrl);

      final details = Quotes.fromJson(response.data);
      return details;
    } catch (e) {
      throw Exception(e);
    }
  }
}

final apiProvider = Provider<QuoteService>((ref) => QuoteService());
