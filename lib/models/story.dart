import 'package:new_story/models/data_src.dart';
import 'package:new_story/models/part.dart';
import 'package:new_story/shared.dart';

class Story {
  static const invalidId = "invalid_id";
  final String? id;
  final String? title;
  final String? contentStory;
  final List<Part> parts;
  final DateTime? lastUpdate;
  final DateTime? createDate;
  final DataSrc src;
  //id != null or id != invalidId
  bool get hasValidId => id != null && id != invalidId;

  const Story({
    required this.id,
    required this.title,
    required this.contentStory,
    required this.parts,
    required this.lastUpdate,
    required this.createDate,
    required this.src,
  });
  //we use this function to convert the database row to a story object
  factory Story.fromMap(Map<String, dynamic> map, {required DataSrc src}) {
    return Story(
      id: map['id'],
      title: map['title'],
      contentStory: map['contentStory'],
      parts: [],
      lastUpdate: tryGetDateTimeFrom(map['lastUpdate']),
      createDate: tryGetDateTimeFrom(map['createDate']),
      src: src,
    ); //01033232160319002604081121
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'contentStory': contentStory,
      // 'parts': parts,
      'lastUpdate': lastUpdate?.toIso8601String(),
      'createDate': createDate?.toIso8601String(),
    };
  }

  Story copyWith({
    String? id,
    String? title,
    String? contentStory,
    List<Part>? parts,
    DateTime? lastUpdate,
    DateTime? createDate,
    DataSrc? src,
  }) {
    return Story(
      id: id ?? this.id,
      title: title ?? this.title,
      contentStory: contentStory ?? contentStory,
      parts: parts ?? this.parts,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      createDate: createDate ?? this.createDate,
      src: src ?? this.src,
    );
  }

  @override
  String toString() {
    return "$Story(id: $id, Title: $title, # Parts: ${parts.length}, Src: $src)";
  }
}
