// import 'package:new_story/models/part.dart';
// import 'package:new_story/models/story.dart';

// final List<Story> dummyStories = [
//   // ─────────────────────────────
//   // Story 1
//   // ─────────────────────────────
//   Story(
//     id: 'invalid_id',
//     title: 'The Desert Knight',
//     contentStory:
//         'A brave knight travels across the desert in search of a lost golden city and discovers wisdom hidden in the journey.',
//     lastUpdate: DateTime(2024, 5, 10),
//     createDate: DateTime(2024, 4, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Departure',
//         content:
//             'Khalid leaves his tribe after hearing about the legendary golden city hidden beyond the desert dunes.',
//         lastUpdate: DateTime(2024, 4, 2),
//         createDate: DateTime(2024, 4, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Mirage',
//         content:
//             'He faces dehydration and sees a false oasis that tests his endurance and faith.',
//         lastUpdate: DateTime(2024, 4, 3),
//         createDate: DateTime(2024, 4, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Rescue',
//         content:
//             'Khalid saves a caravan under attack, gaining allies and supplies.',
//         lastUpdate: DateTime(2024, 4, 4),
//         createDate: DateTime(2024, 4, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Betrayal',
//         content:
//             'One of the caravan members is revealed as a spy seeking the city’s location.',
//         lastUpdate: DateTime(2024, 4, 5),
//         createDate: DateTime(2024, 4, 5),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Blind Guide',
//         content:
//             'A blind man becomes Khalid’s guide through the harshest part of the desert.',
//         lastUpdate: DateTime(2024, 4, 6),
//         createDate: DateTime(2024, 4, 6),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Golden City',
//         content:
//             'They discover a hidden city filled with ancient knowledge instead of gold.',
//         lastUpdate: DateTime(2024, 4, 7),
//         createDate: DateTime(2024, 4, 7),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Return',
//         content:
//             'Khalid returns home bringing wisdom that transforms his tribe.',
//         lastUpdate: DateTime(2024, 4, 8),
//         createDate: DateTime(2024, 4, 8),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 2
//   // ─────────────────────────────
//   Story(
//     id: Story.invalidId,
//     title: 'Message in a Bottle',
//     contentStory:
//         'A girl finds a mysterious message in a bottle that reveals secrets about her missing parents.',
//     lastUpdate: DateTime(2024, 6, 15),
//     createDate: DateTime(2024, 5, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Bottle',
//         content:
//             'Laila finds a green bottle containing a strange letter on the beach.',
//         lastUpdate: DateTime(2024, 5, 2),
//         createDate: DateTime(2024, 5, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Secret',
//         content: 'Her grandmother reveals hidden truths about her parents.',
//         lastUpdate: DateTime(2024, 5, 3),
//         createDate: DateTime(2024, 5, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Old House',
//         content: 'A clue leads her to an abandoned house near an old tree.',
//         lastUpdate: DateTime(2024, 5, 4),
//         createDate: DateTime(2024, 5, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Harbor',
//         content: 'She travels to a harbor seeking answers.',
//         lastUpdate: DateTime(2024, 5, 5),
//         createDate: DateTime(2024, 5, 5),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Truth',
//         content: 'She learns her father faked his death to protect the family.',
//         lastUpdate: DateTime(2024, 5, 6),
//         createDate: DateTime(2024, 5, 6),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'Reunion',
//         content: 'She finally meets her father again.',
//         lastUpdate: DateTime(2024, 5, 7),
//         createDate: DateTime(2024, 5, 7),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 3
//   // ─────────────────────────────
//   Story(
//     id: Story.invalidId,
//     title: 'The Palm Guardian',
//     contentStory:
//         'An old man fights to protect his ancestral palm farm from being destroyed.',
//     lastUpdate: DateTime(2024, 7, 20),
//     createDate: DateTime(2024, 6, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Farm',
//         content: 'Old Salem protects his family palm farm.',
//         lastUpdate: DateTime(2024, 6, 2),
//         createDate: DateTime(2024, 6, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Notice',
//         content: 'He receives a notice of land confiscation.',
//         lastUpdate: DateTime(2024, 6, 3),
//         createDate: DateTime(2024, 6, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Fight',
//         content: 'His grandson helps him fight legally.',
//         lastUpdate: DateTime(2024, 6, 4),
//         createDate: DateTime(2024, 6, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Court',
//         content: 'They win a temporary legal victory.',
//         lastUpdate: DateTime(2024, 6, 5),
//         createDate: DateTime(2024, 6, 5),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Fire',
//         content: 'Someone tries to burn the farm.',
//         lastUpdate: DateTime(2024, 6, 6),
//         createDate: DateTime(2024, 6, 6),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Victory',
//         content: 'The court protects the land permanently.',
//         lastUpdate: DateTime(2024, 6, 7),
//         createDate: DateTime(2024, 6, 7),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 4
//   Story(
//     id: Story.invalidId,
//     title: 'Shadow of the Moon',
//     contentStory:
//         'A student discovers her grandfather’s forgotten scientific legacy.',
//     lastUpdate: DateTime(2024, 8, 5),
//     createDate: DateTime(2024, 7, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'Discovery',
//         content: 'She finds old scientific notes.',
//         lastUpdate: DateTime(2024, 7, 2),
//         createDate: DateTime(2024, 7, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'Research',
//         content: 'She investigates the lost theory.',
//         lastUpdate: DateTime(2024, 7, 3),
//         createDate: DateTime(2024, 7, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'Proof',
//         content: 'She proves her grandfather’s work.',
//         lastUpdate: DateTime(2024, 7, 4),
//         createDate: DateTime(2024, 7, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'Recognition',
//         content: 'The scientific community acknowledges it.',
//         lastUpdate: DateTime(2024, 7, 5),
//         createDate: DateTime(2024, 7, 5),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 5
//   Story(
//     id: Story.invalidId,
//     title: 'Road to Damascus',
//     contentStory:
//         'A chef searches for his grandmother’s lost recipe in Damascus.',
//     lastUpdate: DateTime(2024, 9, 12),
//     createDate: DateTime(2024, 8, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Recipe',
//         content: 'He loses his grandmother’s recipe.',
//         lastUpdate: DateTime(2024, 8, 2),
//         createDate: DateTime(2024, 8, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Journey',
//         content: 'He travels to Damascus.',
//         lastUpdate: DateTime(2024, 8, 3),
//         createDate: DateTime(2024, 8, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Old Neighbor',
//         content: 'He finds someone who knew his grandmother.',
//         lastUpdate: DateTime(2024, 8, 4),
//         createDate: DateTime(2024, 8, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Secret Ingredient',
//         content: 'He discovers the missing spice.',
//         lastUpdate: DateTime(2024, 8, 5),
//         createDate: DateTime(2024, 8, 5),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Taste',
//         content: 'He recreates the perfect dish.',
//         lastUpdate: DateTime(2024, 8, 6),
//         createDate: DateTime(2024, 8, 6),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 6
//   Story(
//     id: Story.invalidId,
//     title: 'The Watchmaker',
//     contentStory:
//         'A craftsman discovers his grandfather’s hidden royal history.',
//     lastUpdate: DateTime(2024, 10, 1),
//     createDate: DateTime(2024, 9, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Watch',
//         content: 'He finds an old royal watch.',
//         lastUpdate: DateTime(2024, 9, 2),
//         createDate: DateTime(2024, 9, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Journal',
//         content: 'His grandfather’s secret journal.',
//         lastUpdate: DateTime(2024, 9, 3),
//         createDate: DateTime(2024, 9, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Museum',
//         content: 'Experts confirm its value.',
//         lastUpdate: DateTime(2024, 9, 4),
//         createDate: DateTime(2024, 9, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Legacy',
//         content: 'He continues the craft.',
//         lastUpdate: DateTime(2024, 9, 5),
//         createDate: DateTime(2024, 9, 5),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 7
//   Story(
//     id: Story.invalidId,
//     title: 'Song of the Mountain',
//     contentStory: 'A singer revives forgotten mountain folk songs.',
//     lastUpdate: DateTime(2024, 11, 5),
//     createDate: DateTime(2024, 10, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'Return',
//         content: 'She returns to her village.',
//         lastUpdate: DateTime(2024, 10, 2),
//         createDate: DateTime(2024, 10, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Songs',
//         content: 'She records old folk songs.',
//         lastUpdate: DateTime(2024, 10, 3),
//         createDate: DateTime(2024, 10, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Girls',
//         content: 'She teaches young girls.',
//         lastUpdate: DateTime(2024, 10, 4),
//         createDate: DateTime(2024, 10, 4),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Festival',
//         content: 'They perform in a village festival.',
//         lastUpdate: DateTime(2024, 10, 5),
//         createDate: DateTime(2024, 10, 5),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 8
//   Story(
//     id: Story.invalidId,
//     title: 'The Lost Library',
//     contentStory:
//         'An explorer discovers a hidden underground library filled with ancient knowledge.',
//     lastUpdate: DateTime(2024, 12, 1),
//     createDate: DateTime(2024, 11, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Map',
//         content: 'A mysterious map leads to ruins.',
//         lastUpdate: DateTime(2024, 11, 2),
//         createDate: DateTime(2024, 11, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Entrance',
//         content: 'He finds a hidden door underground.',
//         lastUpdate: DateTime(2024, 11, 3),
//         createDate: DateTime(2024, 11, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Books',
//         content: 'Ancient books fill the library.',
//         lastUpdate: DateTime(2024, 11, 4),
//         createDate: DateTime(2024, 11, 4),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 9
//   Story(
//     id: Story.invalidId,
//     title: 'The Hidden Painter',
//     contentStory: 'A girl discovers her father was a forgotten famous painter.',
//     lastUpdate: DateTime(2025, 1, 10),
//     createDate: DateTime(2024, 12, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Painting',
//         content: 'She finds hidden paintings.',
//         lastUpdate: DateTime(2024, 12, 2),
//         createDate: DateTime(2024, 12, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Gallery',
//         content: 'Experts evaluate the art.',
//         lastUpdate: DateTime(2024, 12, 3),
//         createDate: DateTime(2024, 12, 3),
//       ),
//     ],
//   ),

//   // ─────────────────────────────
//   // Story 10
//   Story(
//     id: Story.invalidId,
//     title: 'The Time Letter',
//     contentStory:
//         'A boy receives a letter from the future warning him about choices.',
//     lastUpdate: DateTime(2025, 2, 5),
//     createDate: DateTime(2025, 1, 1),
//     parts: [
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Letter',
//         content: 'A mysterious future letter arrives.',
//         lastUpdate: DateTime(2025, 1, 2),
//         createDate: DateTime(2025, 1, 2),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Warning',
//         content: 'It predicts his future mistakes.',
//         lastUpdate: DateTime(2025, 1, 3),
//         createDate: DateTime(2025, 1, 3),
//       ),
//       Part(
//         id: Part.invalidId,
//         storyId: Story.invalidId,
//         title: 'The Choice',
//         content: 'He changes his decisions.',
//         lastUpdate: DateTime(2025, 1, 4),
//         createDate: DateTime(2025, 1, 4),
//       ),
//     ],
//   ),
// ];
