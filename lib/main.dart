import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:inventor_desgin_studio/providers/auth_provider.dart';
import 'package:inventor_desgin_studio/providers/user_provider.dart';
import 'package:inventor_desgin_studio/providers/app_provider.dart';
import 'package:inventor_desgin_studio/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Enable performance overlay in debug mode
  // debugPaintSizeEnabled = true;
  // debugPaintBaselinesEnabled = true;
  // debugPaintPointersEnabled = true;
  // debugRepaintRainbowEnabled = true;

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => AppProvider()),
      ],
      child: App(key: const Key('main_app')),
    );
  }
}

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    _initializeProviders();
  }

  Future<void> _initializeProviders() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final appProvider = Provider.of<AppProvider>(context, listen: false);

    // Initialize auth and app providers
    await Future.wait([
      authProvider.initialize(),
      appProvider.initialize(),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Inventor Design Studio",
      theme: ThemeData.dark().copyWith(
        visualDensity: VisualDensity.adaptivePlatformDensity,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      home: const SplashScreen(),
    );
  }
}
