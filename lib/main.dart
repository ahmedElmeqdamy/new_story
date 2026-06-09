import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:new_story/db.dart';
import 'package:new_story/firebase_options.dart';
import 'package:new_story/models/firestore.dart';
import 'package:new_story/shared_prefrences.dart';
import 'package:new_story/stories_list_screen.dart';

late Db db;
late FirestoreHelper firestoreHelper;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefsHelper.initial();
  // final lastFetch = SharedPrefsHelper.getLastFetch();
  // if (lastFetch != null) {
  //   lastStoriesFetch = Timestamp.fromDate(lastFetch);
  // }

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  db = Db();
  firestoreHelper = FirestoreHelper();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StoriesListScreen(),
    );
  }
}
