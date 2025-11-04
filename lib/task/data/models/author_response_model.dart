import 'package:task_app/task/data/models/doc_model.dart';
import 'package:task_app/task/domain/entities/author/author_entity.dart';

class AuthorResponseModel extends AuthorResponseEntity {
  AuthorResponseModel({super.numFoundExact, super.docs, super.start, super.numFound});



  factory AuthorResponseModel.fromJson(Map<String, dynamic> json) => AuthorResponseModel(
    numFound: json['numFound'] as int?,
    start: json['start'] as int?,
    numFoundExact: json['numFoundExact'] as bool?,
    docs: json['docs'] == null ? null : (json['docs'] as List<dynamic>?)
        ?.map((e) => DocModel.fromJson(e as Map<String, dynamic>))
        .toList() ??
        [],
  );
}
