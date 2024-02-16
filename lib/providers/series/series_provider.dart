import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/models/series/series_model.dart';

import 'package:kungwi/providers/api/api_service_provider.dart';

final fetchTrendingSeriesProvider =
    FutureProvider<List<SeriesModelData>>((ref) async {
  SeriesModel fetchSeries =
      await ref.read(apiServiceProvider).fetchTrendingSeries;
  return fetchSeries.data as List<SeriesModelData>;
});

final fetchAllSeriesProvider =
    FutureProvider<List<SeriesModelData>>((ref) async {
  SeriesModel fetchSeries = await ref.read(apiServiceProvider).fetchAllSeries;
  return fetchSeries.data as List<SeriesModelData>;
});
