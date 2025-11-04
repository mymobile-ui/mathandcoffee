import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Remove hash from Flutter web URLs for cleaner navigation.
  setUrlStrategy(PathUrlStrategy());
  runApp(const MathAndCoffeApp());
}
