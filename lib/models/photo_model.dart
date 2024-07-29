import 'result_model.dart';

class PhotoModel {
  int? total;
  int? totalPage;
  List<Result>? results;

  PhotoModel({
    required this.total,
    required this.totalPage,
    required this.results,
  });

  factory PhotoModel.fromJson(Map<String, Object?> json) => PhotoModel(
        total: json["total"] as int?,
        totalPage: json["totalPage"] as int?,
        results: json["results"] != null
            ? List<Map<String, Object?>>.from(
                json["results"] as List,
              ).map(Result.fromJson).toList()
            : <Result>[],
      );
}
