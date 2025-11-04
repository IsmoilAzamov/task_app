import 'package:task_app/task/domain/entities/author/author_entity.dart';

import '../../../core/network/datastate.dart';

abstract class AuthorsRepository {
  Future<DataState<AuthorResponseEntity>> getAuthors(String searchQuery);
}
