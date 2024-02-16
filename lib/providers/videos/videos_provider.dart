import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:kungwi/models/videos/videos_model.dart';
import 'package:kungwi/providers/api/api_service_provider.dart';

final fetchTrendingVideosProvider =
    FutureProvider<List<VideosModelData>>((ref) async {
  VideosModel fetchVideos =
      await ref.read(apiServiceProvider).fetchTrendingVideos;
  return fetchVideos.data as List<VideosModelData>;
});
final fetchAllVideosProvider =
    FutureProvider<List<VideosModelData>>((ref) async {
  VideosModel fetchVideos = await ref.read(apiServiceProvider).fetchAllVideos;
  return fetchVideos.data as List<VideosModelData>;
});
