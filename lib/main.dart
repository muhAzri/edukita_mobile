import 'package:core/app.dart';
import 'package:core/core.dart';
import 'package:edukita/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await Core.setUpInjector();

  runApp(const MainApp());
}
