class DocEntity {
  DocEntity({
    this.alternateNames,
    this.birthDate,
    this.key,
    this.name,
    this.topSubjects,
    this.topWork,
    this.type,
    this.workCount,
    this.ratingsAverage,
    this.ratingsSortable,
    this.ratingsCount,
    this.ratingsCount1,
    this.ratingsCount2,
    this.ratingsCount3,
    this.ratingsCount4,
    this.ratingsCount5,
    this.wantToReadCount,
    this.alreadyReadCount,
    this.currentlyReadingCount,
    this.readinglogCount,
    this.version,
  });

  List<String>? alternateNames;
  String? birthDate;
  String? key;
  String? name;
  List<String>? topSubjects;
  String? topWork;
  String? type;
  int? workCount;
  double? ratingsAverage;
  double? ratingsSortable;
  int? ratingsCount;
  int? ratingsCount1;
  int? ratingsCount2;
  int? ratingsCount3;
  int? ratingsCount4;
  int? ratingsCount5;
  int? wantToReadCount;
  int? alreadyReadCount;
  int? currentlyReadingCount;
  int? readinglogCount;
  int? version;
}
