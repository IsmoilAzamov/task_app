import 'package:task_app/task/domain/entities/author/author_entity.dart';

sealed class AuthorsState {}


class AuthorsInitialState extends AuthorsState {}


class AuthorsLoadedState extends AuthorsState {
  final AuthorResponseEntity authorResponse;

  AuthorsLoadedState(this.authorResponse);
}

class AuthorsLoadingState extends AuthorsState {}

class AuthorsErrorState extends AuthorsState {
  final String error;

  AuthorsErrorState(this.error);
}
