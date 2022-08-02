import 'package:device_preview/device_preview.dart';
import 'package:flutter/material.dart'
    show BuildContext, Key, MaterialApp, StatelessWidget, Widget, WidgetsFlutterBinding, runApp;
import 'package:flutter/services.dart' show SystemChrome;
import 'package:hive_flutter/hive_flutter.dart';
import 'package:provider/provider.dart' show MultiProvider, Provider;

import 'src/database/functions.dart' show HiveFuntions;
import 'src/helpers/routes/routes.dart';
import 'src/helpers/themes/themes.dart' show uiConfig;
import 'src/providers/providers.dart';
import 'src/providers/theme/theme.dart' show ThemeProvider;
import 'src/view/wrapper.dart';
// import 'src/screens/wrapper.dart' show Wrapper;

Future<void> main() async {
  await _init();
  runApp(
    DevicePreview(
      enabled: false,
      tools: const [
        ...DevicePreview.defaultTools,
      ],
      builder: (context) => MultiProvider(
        providers: providers,
        child: const Main(),
      ),
    ),
  );
}

Future<void> _init() async {
  await Hive.initFlutter();
  HiveFuntions.registerHiveAdepters();
  await HiveFuntions.openAllBoxes();
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(uiConfig);
}

class Main extends StatelessWidget {
  const Main({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _theme = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: _theme.theme,
      home: Wrapper(),
      routes: routes,
     debugShowMaterialGrid: false,
     showPerformanceOverlay: false,
     showSemanticsDebugger: false,
     
    );
  }
}


