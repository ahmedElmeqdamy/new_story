import 'dart:developer';

import 'package:new_story/db.dart';
import 'package:new_story/models/firestore.dart';
import 'package:new_story/models/story.dart';

class StoryRepository {
  final Db _localDb;
  final FirestoreHelper _remoteDb;

  StoryRepository({required Db localDb, required FirestoreHelper remoteDb})
      : _localDb = localDb,
        _remoteDb = remoteDb;

  /// Fetches stories using offline-first strategy:
  /// 1. Returns local data immediately if available
  /// 2. Syncs with Firestore in the background
  /// 3. Calls [onUpdate] when fresh data arrives from Firestore
  ///
  /// If local DB is empty, fetches directly from Firestore,
  /// saves to local, and returns the result.
  Future<List<Story>> fetchStories({
    Function(List<Story>)? onUpdate,
  }) async {
    // Step 1: Try local database first (fast, offline)
    final localStories = await _localDb.fetchStories();

    if (localStories.isNotEmpty) {
      log(
        'Loaded ${localStories.length} stories from local DB',
        name: 'StoryRepository',
      );
      // Step 2: Sync with Firestore in background (don't await)
      _syncFromFirestore(onUpdate);
      return localStories;
    }

    // Step 3: Local is empty — fetch from Firestore directly
    log('Local DB empty, fetching from Firestore...', name: 'StoryRepository');
    try {
      final remoteStories = await _remoteDb.fetchStories();
      if (remoteStories.isNotEmpty) {
        await _saveToLocalDb(remoteStories);
        log(
          'Saved ${remoteStories.length} stories from Firestore to local DB',
          name: 'StoryRepository',
        );
        return remoteStories;
      }
    } catch (e, st) {
      log(
        'Firestore fetch failed',
        error: e,
        stackTrace: st,
        name: 'StoryRepository',
      );
    }

    return [];
  }

  /// Background sync: fetches latest from Firestore, updates local DB,
  /// and notifies via [onUpdate] callback
  Future<void> _syncFromFirestore(Function(List<Story>)? onUpdate) async {
    try {
      final remoteStories = await _remoteDb.fetchStories();
      if (remoteStories.isNotEmpty) {
        await _saveToLocalDb(remoteStories);
        onUpdate?.call(remoteStories);
        log(
          'Background sync complete: ${remoteStories.length} stories',
          name: 'StoryRepository',
        );
      }
    } catch (e, st) {
      log(
        'Background sync failed',
        error: e,
        stackTrace: st,
        name: 'StoryRepository',
      );
    }
  }

  /// Saves a list of stories (with their parts) to the local database
  Future<void> _saveToLocalDb(List<Story> stories) async {
    for (final story in stories) {
      await _localDb.insertOrUpdateStory(story);
    }
  }
}
