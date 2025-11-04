import 'package:task_app/core/network/datastate.dart';
import 'package:task_app/core/error/get_checked_response.dart';
import 'package:task_app/task/domain/entities/author/author_entity.dart';

import '../../domain/repositories/authors_repository.dart';
import '../remote/authors_api_service.dart';

class AuthorsRepositoryImpl implements AuthorsRepository {
  final AuthorsApiService _authorsApiService;

  AuthorsRepositoryImpl(this._authorsApiService);

  @override
  Future<DataState<AuthorResponseEntity>> getAuthors(String searchQuery) =>
      getCheckedResponse(() => _authorsApiService.getAuthors(searchQuery));
}
