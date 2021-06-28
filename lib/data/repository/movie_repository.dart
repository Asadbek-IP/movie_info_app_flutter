import 'package:movie_info_app_flutter/data/model/credits_response.dart';
import 'package:movie_info_app_flutter/data/model/genre_response.dart';
import 'package:movie_info_app_flutter/data/model/movie.dart';
import 'package:movie_info_app_flutter/data/model/movie_list_response.dart';
import 'package:movie_info_app_flutter/data/model/movie_review_response.dart';
import 'package:movie_info_app_flutter/data/model/movie_video_response.dart';
import 'package:movie_info_app_flutter/data/network/api_client.dart';
import 'package:movie_info_app_flutter/data/pref/shared_pref_helper.dart';

class MovieRepository {
  final ApiClient client = ApiClient();
  final SharedPrefHelper pref = SharedPrefHelper.instance;

  Future<GenreResponse> getGenres() async {
    return await client.getGenres();
  }

  Future<MovieListResponse> getPopularMovies(int page) async {
    return await client.getPopularMovies(page);
  }

  Future<MovieListResponse> getTopRatedMovies(int page) async {
    return await client.getTopRatedMovies(page);
  }

  Future<MovieListResponse> getUpcomingMovies(int page) async {
    return await client.getUpcomingMovies(page);
  }

  Future<MovieListResponse> searchMovies(String query, int page) async {
    return await client.searchMovies(query, page);
  }

  Future<Movie?> getMovie(int movieId) async {
    return await client.getMovie(movieId);
  }

  Future<MovieReviewResponse> getMovieReviews(int movieId, int page) async {
    return await client.getMovieReviews(movieId, page);
  }

  Future<MovieVideoResponse> getMovieVideos(int movieId) async {
    return await client.getMovieVideos(movieId);
  }

  Future<CreditsResponse> getMovieCredits(int movieId) async {
    return await client.getMovieCredits(movieId);
  }

  Future<bool> rateMovie(int movieId, int rating) async {
    String? sessionId = await pref.getValidSessionIdOrNull();
    if (sessionId == null) {
      var res = await client.createGuestSession();
      if (res.error.isEmpty) {
        sessionId = res.guestSessionId;
        await pref.saveGuestSessionId(res.guestSessionId, res.expiresAt);
      } else {
        return false;
      }
    }
    var res = await client.rateMovie(movieId, sessionId, rating);
    return res.statusMessage.contains("Success");
  }
}
