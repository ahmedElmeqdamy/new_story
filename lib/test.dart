import 'dart:async';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreHelper {
  final _firestore = FirebaseFirestore.instance;

  CollectionReference get storiesRef => _firestore.collection('stories');
  CollectionReference get partsRef => _firestore.collection('parts');

  Future<void> getStoryById(String storyId) async {
    try {
      final story = await storiesRef
          .doc(storyId)
          .get()
          .timeout(Duration(seconds: 5));
      log(story.data.toString());
    } on TimeoutException catch (error) {
      log('error request time out $error');
    } on FirebaseException catch (error) {
      log('error firebase $error');
    } catch (error) {
      log('Unexpected Erroe $error');
    }
  }
}
