import 'package:flutter/material.dart';
import 'package:new_story/data/stories.dart';
import 'package:new_story/main.dart';
import 'package:new_story/models/story_parts.dart';
import 'package:new_story/shared_prefrences.dart';

class StoriesListScreen extends StatefulWidget {
  const StoriesListScreen({super.key});

  @override
  State<StoriesListScreen> createState() => _StoriesListScreenState();
}

class _StoriesListScreenState extends State<StoriesListScreen> {
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Stories')),
      body: Column(
        children: [
          Text(
            "LastFetch: ${SharedPrefsHelper.getLastFetch()?.toIso8601String().substring(0, 16)}",
            textAlign: .center,
            style: TextStyle(fontWeight: .bold, fontSize: 20),
          ),
          Divider(),
          Expanded(
            child: loading
                ? Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: EdgeInsets.all(16),
                    itemBuilder: (context, index) {
                      final story = stories.values.toList()[index];
                      return ListTile(
                        title: Text(story.title ?? 'Untitled Story'),
                        subtitle: Text(
                          "${story.contentStory ?? 'No summery'} - ${story.lastUpdate?.toString().substring(0, 16)} - ${story.src == .online ? 'online' : 'offline'}",
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => StoryParts(story: story),
                            ),
                          );
                        },
                      );
                    },
                    itemCount: stories.length,
                  ),
          ),
        ],
      ),
      floatingActionButton: Column(
        spacing: 10,
        mainAxisAlignment: .end,
        children: [
          // FETCHS DATA FROM OFFLINE DATABASE
          FloatingActionButton(
            heroTag: 'db',
            onPressed: () async {
              // firestoreHelper.uploadStories(dummyStories);
              setState(() {
                loading = true;
              });

              //THIS FAB IS FOR FETCH ALL STORIES FROM LOCAL DATABASE
              //and store it in storiesList
              final storiesList = await db.fetchStories();

              stories = stories
                ..addAll(
                  Map.fromIterable(storiesList, key: (story) => story.id),
                );

              await Future.delayed(Duration(milliseconds: 500));
              loading = false;
              setState(() {});
            },

            child: Text("db"),
            // Icon(Icons.storage_rounded),
          ),
          // FETCHS DATA FROM FIRESTORE
          FloatingActionButton(
            heroTag: 'fb',
            onPressed: () async {
              // firestoreHelper.uploadStories(dummyStories);
              setState(() {
                loading = true;
              });
              final storiesList = await firestoreHelper.fetchStories();
              stories = stories
                ..addAll(
                  Map.fromIterable(storiesList, key: (story) => story.id),
                );
              loading = false;
              setState(() {});
            },
            child: Text("fb"),
            // Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }
}
// enter the meeting!