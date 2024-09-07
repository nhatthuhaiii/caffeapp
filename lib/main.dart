import 'package:caffeapp/ui/cafeapp.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

import 'firebase_options.dart';
import 'package:uni_links/uni_links.dart';
Future<void> main() async {
  // Đảm bảo Flutter binding được khởi tạo
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();


  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);


  await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform
  );
  await Future.delayed(Duration(seconds: 1));

  FlutterNativeSplash.remove();


  runApp(cafffeapphome());
}