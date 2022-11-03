import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quotes/service/quote_service.dart';

final getQuoteProvider =
    FutureProvider((ref) => ref.watch(apiProvider).getResponse());
