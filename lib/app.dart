import 'package:flutter/material.dart';
import 'package:native_setup/screen/platform_widget_demo.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Platform Widgets Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: const PlatformWidgetsDemo(),
    );
  }
}
