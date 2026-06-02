import 'dart:async';
import 'dart:developer';

import 'package:new_story/data/stories.dart';
import 'package:new_story/main.dart';

Timer? storiesTimer;

Future<void> getDataEvery10S() async {
  log('Fetching stories...', name: 'Timer');

  final storiesList = await firestoreHelper.fetchStories();

  log('Fetched ${storiesList.length} stories', name: 'Timer');

  stories.addAll(Map.fromIterable(storiesList, key: (story) => story.id));
}

void initialize() {
  storiesTimer = Timer.periodic(const Duration(seconds: 10), (_) async {
    await getDataEvery10S();
  });
}
//01058418059001
