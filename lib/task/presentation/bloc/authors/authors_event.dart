sealed class AuthorsEvent{}

class AuthorsLoadEvent extends AuthorsEvent{
  final String searchQuery;

  AuthorsLoadEvent({required this.searchQuery});
}