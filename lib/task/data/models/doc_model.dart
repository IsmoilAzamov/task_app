import '../../domain/entities/author/doc_entity.dart';

class DocModel extends DocEntity {
  DocModel({
    super.alternateNames,
    super.birthDate,
    super.key,
    super.name,
    super.topSubjects,
    super.topWork,
    super.type,
    super.workCount,
    super.ratingsAverage,
    super.ratingsSortable,
    super.ratingsCount,
    super.ratingsCount1,
    super.ratingsCount2,
    super.ratingsCount3,
    super.ratingsCount4,
    super.ratingsCount5,
    super.wantToReadCount,
    super.alreadyReadCount,
    super.currentlyReadingCount,
    super.readinglogCount,
    super.version,
  });

  DocModel.fromJson(dynamic json) {
    alternateNames = json['alternate_names'] != null ? json['alternate_names'].cast<String>() : [];
    birthDate = json['birth_date'];
    key = json['key'];
    name = json['name'];
    topSubjects = json['top_subjects'] != null ? json['top_subjects'].cast<String>() : [];
    topWork = json['top_work'];
    type = json['type'];
    workCount = json['work_count'];
    ratingsAverage = json['ratings_average'];
    ratingsSortable = json['ratings_sortable'];
    ratingsCount = json['ratings_count'];
    ratingsCount1 = json['ratings_count_1'];
    ratingsCount2 = json['ratings_count_2'];
    ratingsCount3 = json['ratings_count_3'];
    ratingsCount4 = json['ratings_count_4'];
    ratingsCount5 = json['ratings_count_5'];
    wantToReadCount = json['want_to_read_count'];
    alreadyReadCount = json['already_read_count'];
    currentlyReadingCount = json['currently_reading_count'];
    readinglogCount = json['readinglog_count'];
    version = json['_version_'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['alternate_names'] = alternateNames;
    map['birth_date'] = birthDate;
    map['key'] = key;
    map['name'] = name;
    map['top_subjects'] = topSubjects;
    map['top_work'] = topWork;
    map['type'] = type;
    map['work_count'] = workCount;
    map['ratings_average'] = ratingsAverage;
    map['ratings_sortable'] = ratingsSortable;
    map['ratings_count'] = ratingsCount;
    map['ratings_count_1'] = ratingsCount1;
    map['ratings_count_2'] = ratingsCount2;
    map['ratings_count_3'] = ratingsCount3;
    map['ratings_count_4'] = ratingsCount4;
    map['ratings_count_5'] = ratingsCount5;
    map['want_to_read_count'] = wantToReadCount;
    map['already_read_count'] = alreadyReadCount;
    map['currently_reading_count'] = currentlyReadingCount;
    map['readinglog_count'] = readinglogCount;
    map['_version_'] = version;
    return map;
  }
}
