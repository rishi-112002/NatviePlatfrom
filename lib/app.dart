import 'package:flutter/material.dart';
import 'package:native_setup/screen/platform_widget_demo.dart';

class ApdaptiveWidgetApp extends StatelessWidget {
  const ApdaptiveWidgetApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Platform Widgets Demo',
      theme: ThemeData(
        useMaterial3: true,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      darkTheme: ThemeData.dark(),
      home: const PlatformWidgetsDemo(),
    );
  }
}
