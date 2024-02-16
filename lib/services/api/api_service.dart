import 'package:kungwi/services/api/series/series_service.dart';
import 'package:kungwi/services/api/videos/videos_service.dart';
import 'package:kungwi/services/firebase/firebase_service.dart';
import 'package:kungwi/services/profile/profile_service.dart';

class ApiService {
  final fetchTrendingVideos = getTrendingVideos();
  final fetchTrendingSeries = getTrendingSeries();
  final fetchAllVideos = getAllVideos();
  final fetchAllSeries = getAllSeries();

  fetchUserCredit(String userID) {
    return getUserCredit(userID);
  }

  createUpdateFirebase(String userID, String token, String device) {
    return createUpdateFirebaseService(userID, token, device);
  }
}
