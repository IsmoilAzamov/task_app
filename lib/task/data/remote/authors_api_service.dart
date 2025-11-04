import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';
import 'package:task_app/core/constants/urls.dart';
import 'package:task_app/task/data/models/author_response_model.dart';

part 'authors_api_service.g.dart';

@RestApi(baseUrl: Urls.baseUrl)
abstract class AuthorsApiService {
  factory AuthorsApiService(Dio dio, {String baseUrl}) = _AuthorsApiService;

  @GET('/search/authors.json')
  Future<HttpResponse<AuthorResponseModel>> getAuthors(@Query("q") String query);
}
