import 'package:flutter/material.dart';
import 'package:new_story/models/story.dart';

class StoryParts extends StatelessWidget {
  final Story story;
  const StoryParts({super.key, required this.story});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(story.title ?? 'Untitled Story')),
      body: ListView.separated(
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,

              children: [
                Text(story.parts[index].title ?? 'Untitled Story'),
                Text(story.parts[index].content ?? 'No content'),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(height: 1, color: Colors.grey);
        },
        itemCount: story.parts.length,
      ),
    );
  }
}
