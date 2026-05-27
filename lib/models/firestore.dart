import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:new_story/main.dart';
import 'package:new_story/models/part.dart';
import 'package:new_story/models/story.dart';
import 'package:new_story/shared.dart';
import 'package:new_story/shared_prefrences.dart';

class FirestoreHelper {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get storiesRef => _firestore.collection('stories');
  CollectionReference get partsRef => _firestore.collection('parts');

  //this is for fetching a single story from firestore using its ID
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
        storyQuerySnapshot = await storiesRef
            .where("lastUpdate", isGreaterThan: lastFetch)
            .get();
        partsQuerySnapshot = await partsRef
            .where("lastUpdate", isGreaterThan: lastFetch)
            .get();
      } else {
        log('firsty time', name: 'first time to open app');
        storyQuerySnapshot = await storiesRef.get();
        partsQuerySnapshot = await partsRef.get();
      }
      //storyQuerySnapshot  lastUpdate al stories al lsa mdafa aw m3mlha updated
      //partsQuerySnapshot  lastUpdate al parts al lsa mdafa aw m3mlha updated

      final allParts = partsQuerySnapshot.docs;
      final stories = <Story>[];

      for (final storyDoc in storyQuerySnapshot.docs) {
        // if (storyDoc["isDeleted"] case final bool isDeleted when isDeleted) {
        //   db.removeStory(storyDoc.id);
        //   continue;
        // }
        //lastUpdate dah a5er t7des
        final lastUpdateFromFirestore = storyDoc.get("lastUpdate");
        // hal lastUpdate = final Timpstamp
        if (lastUpdateFromFirestore
            case final Timestamp lastUpdateFromFirestore) {
          //hal awel mara tft7 al app
          if (lastStoriesFetch == null) {
            lastStoriesFetch = lastUpdateFromFirestore;
          } else if (lastStoriesFetch case final lastFetch?) {
            if (lastUpdateFromFirestore.millisecondsSinceEpoch >
                lastFetch.millisecondsSinceEpoch) {
              lastStoriesFetch = lastUpdateFromFirestore;
            }
          }
        } //5421047

        log(
          "lastStoriesFetch: ${lastStoriesFetch?.toDate().toIso8601String()}",
        );

        final storyParts = <Part>[];

        for (final partDoc in allParts) {
          if (partDoc["storyId"] == storyDoc.id) {
            final partMap = partDoc.data() as Map<String, dynamic>;
            partMap["id"] = partDoc.id;
            storyParts.add(Part.fromMap(partMap, src: .online));
          }
        }

        // PLEASE CHECK LATER (PERFORMANCE)
        log("--->>>> allParts: ${allParts.length}");

        allParts.removeWhere(
          (partDoc) => storyParts.any((part) => part.id == partDoc.id),
        );

        final storyData = storyDoc.data() as Map<String, dynamic>;
        storyData["id"] = storyDoc.id;

        final story = Story.fromMap(
          storyData,
          src: .online,
        ).copyWith(parts: storyParts);

        stories.add(story);

        db.insertOrUpdateStory(story);
      }

      // Save lastStoriesFetch to SharedPreferences
      if (lastStoriesFetch != null) {
        await SharedPrefsHelper.saveLastFetch(lastStoriesFetch!.toDate());
      }

      log(
        "LEN: ${stories.length.toString()}\n - ${stories.map((story) => story.toString()).join("\n - ")}",
      );

      return stories;
    } catch (e, st) {
      log("fetchStories.error", error: e, stackTrace: st);
      return [];
    }
  }

  // Future<bool> fetchDeletedStories() {
  //   final ids = ["sasdasdsa", "asdasfasf1r1"];
  //   for (var id in ids) {
  //     db.removeStory(id);
  //   }
  // }

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
        //part has id cause it is update
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
