import 'package:cinemapedia/domain/datasources/actors_datasource.dart';
import 'package:cinemapedia/domain/entities/actor.dart';
import 'package:cinemapedia/infrastructure/mappers/actor_mapper.dart';
import 'package:cinemapedia/infrastructure/models/moviedb/credits_response.dart';
import 'package:dio/dio.dart';
import '../../config/constants/environment.dart';

class ActorMovieDbDatasource extends ActorsDatasource {

  final dio = Dio(BaseOptions(
      baseUrl: 'https://api.themoviedb.org/3',
      queryParameters: {
        'api_key': Environment.theMovieDbKey,
        'language':  'es-MX'
      }
  ));

  @override
  Future<List<Actor>> getActorsByMovie(String movieId) async {
    
    final response = await dio.get('/movie/$movieId/credits');

    final actorMovieDBResponse = CreditsResponse.fromJson(response.data);

    final List<Actor> actors = actorMovieDBResponse.cast
    .map(
      (actor) => ActorMapper.castToEntity(actor)
    ).toList();
    
    return actors;
    
  }

}