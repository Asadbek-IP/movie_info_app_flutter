part of 'details_bloc.dart';

@immutable
abstract class DetailsState {
  final Movie movie;

  DetailsState(this.movie);
}

class DetailsInitialState extends DetailsState {
  DetailsInitialState(Movie movie) : super(movie);
}

class DetailsLoadedState extends DetailsState {
  final List<Cast>? casts;
  final List<MovieReview>? reviews;
  final List<MovieVideo>? videos;
  DetailsLoadedState(movie, this.casts, this.reviews, this.videos)
      : super(movie);
}
