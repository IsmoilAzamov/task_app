import 'doc_entity.dart';

class AuthorResponseEntity {
  AuthorResponseEntity({this.numFound, this.start, this.numFoundExact, this.docs});

  final int? numFound;
  final int? start;
  final bool? numFoundExact;
  final List<DocEntity>? docs;
}
