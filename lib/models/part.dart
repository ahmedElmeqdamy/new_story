import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_story/models/data_src.dart';
import 'package:new_story/shared.dart';

class Part {
  static const invalidId = "invalid_id";
  final String? id;
  final String? storyId;
  final DocumentReference? storyRef;
  final String? title;
  final String? content;
  final DateTime? lastUpdate;
  final DateTime? createDate;
  final DataSrc src;

  bool get hasValidId => id != null && id != invalidId;

  const Part({
    required this.id,
    required this.storyId,
    this.storyRef,
    required this.title,
    required this.content,
    required this.lastUpdate,
    required this.createDate,
    required this.src,
  });
  //this method is for converting a map to a part
  factory Part.fromMap(Map<String, dynamic> map, {required DataSrc src}) {
    return Part(
      id: map['id'],
      storyId: map['storyId'],
      storyRef: map['storyRef'],
      title: map['title'],
      content: map['content'],
      lastUpdate: tryGetDateTimeFrom(map['lastUpdate']),
      createDate: tryGetDateTimeFrom(map['createDate']),
      src: src,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storyId': storyId,
      'storyRef': storyRef,
      'title': title,
      'content': content,
      'lastUpdate': lastUpdate?.millisecondsSinceEpoch,
      'createDate': createDate?.millisecondsSinceEpoch,
    };
  }

  Part copyWith({
    String? id,
    String? storyId,
    DocumentReference? storyRef,
    String? title,
    String? content,
    DateTime? lastUpdate,
    DateTime? createDate,
    DataSrc? src,
  }) {
    return Part(
      id: id ?? this.id,
      storyId: storyId ?? this.storyId,
      storyRef: storyRef ?? this.storyRef,
      title: title ?? this.title,
      content: content ?? this.content,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      createDate: createDate ?? this.createDate,
      src: src ?? this.src,
    );
  }
}
