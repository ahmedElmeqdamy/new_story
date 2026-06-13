import 'dart:core';
import 'dart:developer';

import 'package:new_story/models/part.dart';
import 'package:new_story/models/story.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqlite3/sqlite3.dart';

class Db {
  // final Database _db = sqlite3.openInMemory();

  late final Database _db;

  Future<void> _initDB() async {
    final dbPath = await getApplicationDocumentsDirectory();
    final dbFilePath = join(dbPath.path, "temp_database.db");
    _db = sqlite3.open(dbFilePath)..userVersion = 1;
  }

  Db() {
    _createTable();
  }

  void _createTable() async {
    try {
      await _initDB();

      // BLOB in sql = list of int in dart
      _db.execute('''
  CREATE TABLE IF NOT EXISTS stories (
    id TEXT NOT NULL PRIMARY KEY,
    title TEXT,
    content_story TEXT,
    lastUpdate INTEGER,
    createDate INTEGER
  );
''');
      _db.execute('''
  CREATE TABLE IF NOT EXISTS parts (
    id TEXT NOT NULL PRIMARY KEY,
    story_id INTEGER NOT NULL,
    title TEXT,
    content TEXT,
    lastUpdate INTEGER,
    createDate INTEGER
  );
''');
      //    FOREIGN KEY(story_id) REFERENCES stories(id) ON DELETE CASCADE

      log('Tables created successfully', name: 'db.dart');
    } catch (e, st) {
      log(
        'table creation failed: ${e.toString()}',
        stackTrace: st,
        name: 'db.dart',
      );
    }
  }

  //this method is for fetch all stories from local db
  Future<List<Story>> fetchStories() async {
    try {
      final ResultSet resultSet = _db.select('SELECT * FROM stories');
      log("STORIES FROM DATA BASE: ${resultSet.length}");

      final futures = resultSet.map((row) async {
        final story = Story.fromMap(row, src: .offline);
        final parts = await fetchParts(story.id!);
        return story.copyWith(parts: parts);
      }).toList();
      return await Future.wait(futures);
    } catch (error) {
      log('fetch stories failed: ${error.toString()}');
      return [];
    }
  }

  Future<List<Part>> fetchParts(String storyId) async {
    try {
      final ResultSet resultSet = _db.select(
        'SELECT * FROM parts WHERE story_id = ?',
        [storyId],
      );
      return resultSet.map((row) => Part.fromMap(row, src: .offline)).toList();
    } catch (e) {
      log('fetch parts failed: ${e.toString()}');
      return [];
    }
  }

  Future<void> insertOrUpdateStory(Story story) async {
    await Future.delayed(Duration(milliseconds: 250));
    try {
      final params = [
        'id',
        'title',
        'content_story',
        'lastUpdate',
        'createDate',
      ];

      _db.execute(
        'INSERT OR REPLACE INTO stories (${params.join(",")}) VALUES (${params.map((e) => "?").join(",")})',
        [
          story.id,
          story.title,
          story.contentStory,
          story.lastUpdate?.millisecondsSinceEpoch,
          story.createDate?.millisecondsSinceEpoch,
        ],
      );

      await Future.wait([
        for (Part part in story.parts) insertOrUpdatePart(part),
      ]);
    } catch (e) {
      log('add story failed: ${e.toString()}');
    }
  }

  Future<void> insertOrUpdatePart(Part part) async {
    try {
      final params = [
        'id',
        'story_id',
        'title',
        'content',
        'lastUpdate',
        'createDate',
      ];

      _db.execute(
        'INSERT OR REPLACE INTO parts (${params.join(",")}) VALUES (${params.map((e) => "?").join(",")})',
        [
          part.id,
          part.storyId,
          part.title,
          part.content,
          part.lastUpdate?.millisecondsSinceEpoch,
          part.createDate?.millisecondsSinceEpoch,
        ],
      );
    } catch (e) {
      log('add part failed: ${e.toString()}');
    }
  }

  void close() {
    _db.close();
  }

  void removePartsOf(String storyId) {
    // TASK2: implement deleting story from database
    try {
      _db.execute('DELETE FROM parts WHERE story_id = ?', [storyId]);
    } catch (e) {
      log('delete parts failed: ${e.toString()}');
    }
  }

  void removeStory(String id) {
    // TASK1: implement deleting story from database
    try {
      _db.execute('DELETE FROM stories WHERE id = ?', [id]);
      removePartsOf(id);
    } catch (e) {
      log('delete story failed: ${e.toString()}');
    }
  }
}
