class Result {
  String? id;
  String? slug;
  String? created;
  String? updated;
  String? promoted;
  int? width;
  int? height;
  String? color;
  String? blurHash;
  String? description;
  String? altDescription;
  UrlModel? urls;
  LinkModel? links;
  int? likes;
  bool? likedByUser;

  Result({
    required this.id,
    required this.slug,
    required this.created,
    required this.updated,
    required this.promoted,
    required this.width,
    required this.height,
    required this.color,
    required this.blurHash,
    required this.description,
    required this.altDescription,
    required this.urls,
    required this.links,
    required this.likes,
  });

  factory Result.fromJson(Map<String, Object?> json) => Result(
        id: json["id"] as String?,
        slug: json["slug"] as String?,
        created: json["created"] as String?,
        updated: json["updated"] as String?,
        promoted: json["promoted"] as String?,
        width: json["width"] as int?,
        height: json["height"] as int?,
        color: json["color"] as String?,
        blurHash: json["blurHash"] as String?,
        description: json["description"] as String?,
        altDescription: json["alt_description"] as String?,
        urls: UrlModel.fromJson(json["urls"] as Map<String, Object?>),
        links: LinkModel.fromJson(json["links"] as Map<String, Object?>),
        likes: json["likes"] as int?,
      );
}

class UrlModel {
  String? raw;
  String? full;
  String? regular;
  String? small;
  String? thumb;
  String? smalls3;

  UrlModel({
    this.raw,
    this.full,
    this.regular,
    this.small,
    this.thumb,
    this.smalls3,
  });

  factory UrlModel.fromJson(Map<String, Object?> json) => UrlModel(
        full: json["full"] as String?,
        raw: json["raw"] as String?,
        regular: json["regular"] as String?,
        small: json["small"] as String?,
        smalls3: json["smalls3"] as String?,
        thumb: json["thumb"] as String?,
      );
}

class LinkModel {
  String? self;
  String? html;
  String? download;
  String? downloadLocation;

  LinkModel({
    this.self,
    this.html,
    this.download,
    this.downloadLocation,
  });

  factory LinkModel.fromJson(Map<String, Object?> json) => LinkModel(
        self: json["self"] as String?,
        html: json["html"] as String?,
        download: json["download"] as String?,
        downloadLocation: json["download_location"] as String?,
      );

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LinkModel &&
          runtimeType == other.runtimeType &&
          self == other.self &&
          html == other.html &&
          download == other.download &&
          downloadLocation == other.downloadLocation;

  @override
  int get hashCode =>
      self.hashCode ^
      html.hashCode ^
      download.hashCode ^
      downloadLocation.hashCode;

  @override
  String toString() {
    return 'LinkModel{self: $self, html: $html, download: $download, downloadLocation: $downloadLocation}';
  }
}
