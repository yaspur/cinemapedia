import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cinemapedia/presentation/providers/providers.dart';
import 'package:cinemapedia/domain/entities/movie.dart';

final searchQueryProvider = StateProvider<String>((ref) => '');


final searchedMoviesProvider = StateNotifierProvider<SearchMoviesNotifier, List<Movie>>((ref){

  final movieRepository = ref.read(movieRepositoryProvider);

  return SearchMoviesNotifier(searchMovies: movieRepository.searchMovies, ref: ref);

});



typedef SearchMoviesCallBack = Future<List<Movie>> Function(String query);

class SearchMoviesNotifier extends StateNotifier<List<Movie>> {

  final SearchMoviesCallBack searchMovies;
  final Ref ref;

  SearchMoviesNotifier({
    required this.searchMovies,
    required this.ref
  }): super([]);


  Future<List<Movie>> searchMoviesByQuery(String query) async {

    final List<Movie> movies = await searchMovies(query);
    ref.read(searchQueryProvider.notifier).update((state) => query);

    state = movies;

    return movies;

  }

}

