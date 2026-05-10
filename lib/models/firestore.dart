import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_story/main.dart';
import 'package:new_story/models/part.dart';
import 'package:new_story/models/story.dart';
import 'package:new_story/shared.dart';

class FirestoreHelper {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get storiesRef => _firestore.collection('stories');
  CollectionReference get partsRef => _firestore.collection('parts');

  // DocumentReference get storyRef => storiesRef.doc();
  // DocumentReference get partRef => partsRef.doc();

  Future<void> getStoryById(String storyId) async {
    try {
      final story = await storiesRef
          .doc(storyId)
          .get()
          .timeout(Duration(seconds: 5));
      log(story.data().toString());
    } on TimeoutException catch (e, st) {
      log("getStoryById.TimeoutException: $e", error: e, stackTrace: st);
    } on FirebaseException catch (e, st) {
      log("getStoryById.FirebaseException: $e", error: e, stackTrace: st);
    } catch (e, st) {
      log("getStoryById.Exception: $e", error: e, stackTrace: st);
    }
  }

  //this method is working for fetching stories from firestore
  Future<List<Story>> fetchStories() async {
    try {
      final QuerySnapshot storyQuerySnapshot;
      final QuerySnapshot partsQuerySnapshot;

      if (lastStoriesFetch case final lastFetch?) {
        // LF 05/05/2026
        // LU 08/05/2026
        // LF < LU
        storyQuerySnapshot = await storiesRef
            .where("lastUpdate", isGreaterThan: lastFetch)
            .get();
        partsQuerySnapshot = await partsRef
            .where("lastUpdate", isGreaterThan: lastFetch)
            .get();
      } else {
        storyQuerySnapshot = await storiesRef.get();
        partsQuerySnapshot = await partsRef.get();
      }

      final allParts = partsQuerySnapshot.docs;

      final stories = <Story>[];

      for (final storyDoc in storyQuerySnapshot.docs) {
        final lastUpdate = storyDoc.get("lastUpdate");

        if (lastUpdate case final Timestamp lastUpdate) {
          if (lastStoriesFetch == null) {
            lastStoriesFetch = lastUpdate;
          } else if (lastStoriesFetch case final lf?) {
            if (lastUpdate.millisecondsSinceEpoch > lf.millisecondsSinceEpoch) {
              lastStoriesFetch = lastUpdate;
            }
          }
        }

        log(
          "lastStoriesFetch: ${lastStoriesFetch?.toDate().toIso8601String()}",
        );

        final storyData = storyDoc.data() as Map<String, dynamic>;

        storyData["id"] = storyDoc.id;

        final storyParts = <Part>[];

        for (final partDoc in allParts) {
          if (partDoc["storyId"] != storyDoc.id) continue;
          storyParts.add(
            Part.fromMap(
              (partDoc.data() as Map<String, dynamic>)..["id"] = partDoc.id,
              src: .online,
            ),
          );
        }

        // PLEASE CHECK LATER (PERFORMANCE)
        log("--->>>> allParts: ${allParts.length}");
        allParts.removeWhere(
          (partDoc) => storyParts.any((part) => part.id == partDoc.id),
        );

        log("[${storyDoc.id}] storyParts: ${storyParts.length}");

        stories.add(
          Story.fromMap(storyData, src: .online).copyWith(parts: storyParts),
        );
      }

      log(
        "LEN: ${stories.length.toString()}\n - ${stories.map((story) => story.toString()).join("\n - ")}",
      );

      for (final story in stories) {
        await db.insertOrUpdateStory(story);
      }

      return stories;
    } catch (e, st) {
      log("fetchStories.error", error: e, stackTrace: st);
      return [];
    }
  }

  Future<bool> uploadStories(List<Story> stories) async {
    try {
      for (final story in stories) {
        final uploadedStory = await uploadStory(story);
        //ID
        final storyId = uploadedStory?.id;
        //ID mwgo bl f3l
        if (storyId != null) {
          for (var part in story.parts) {
            final updatedPart = part.copyWith(storyId: storyId);
            await uploadPart(updatedPart);
          }
        }
      }
      return true;
    } catch (e, st) {
      log('uploadStories.error', error: e, stackTrace: st);
      return false;
    }
  }

  /// add or update a story
  Future<Story?> uploadStory(Story story) async {
    try {
      if (story.hasValidId) {
        await storiesRef
            .doc(story.id)
            .update(
              story.toMap()
                ..remove("createDate")
                ..["lastUpdate"] = FieldValue.serverTimestamp(),
            );
        return story;
      } else {
        final newStory = await storiesRef.add(
          story.toMap()
            ..remove("id")
            ..["createDate"] = FieldValue.serverTimestamp()
            ..["lastUpdate"] = FieldValue.serverTimestamp(),
        );
        return story.copyWith(id: newStory.id);
      }
    } catch (e, st) {
      log("uploadStory.error", error: e, stackTrace: st);
      return null;
    }
  }

  /// add or update a part
  Future<Part?> uploadPart(Part part) async {
    try {
      if (part.hasValidId) {
        await partsRef
            .doc(part.id)
            .update(
              part.toMap()
                ..remove("createDate")
                ..["storyRef"] = storiesRef.doc(part.storyId)
                ..["lastUpdate"] = FieldValue.serverTimestamp(),
            );
        return part;
      } else {
        final newPart = await partsRef.add(
          part.toMap()
            ..remove("id")
            ..["storyRef"] = storiesRef.doc(part.storyId)
            ..["lastUpdate"] = FieldValue.serverTimestamp()
            ..["createDate"] = FieldValue.serverTimestamp(),
        );
        return part.copyWith(id: newPart.id);
      }
    } catch (e, st) {
      log("uploadPart.error", error: e, stackTrace: st);
      return null;
    }
  }
}
