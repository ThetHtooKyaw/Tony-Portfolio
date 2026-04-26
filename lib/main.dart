import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:provider/provider.dart';
import 'package:tony_portfolio/core/theme/app_theme.dart';
import 'package:tony_portfolio/core/utils/router.dart';
import 'package:tony_portfolio/src/contact/repo/contact_service.dart';
import 'package:tony_portfolio/src/contact/view_model/contact_view_model.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    setUrlStrategy(PathUrlStrategy());
  }

  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("Failed to load .env file: $e");
  }

  runApp(
    MultiProvider(
      providers: [
        Provider(create: (context) => ContactService()),

        ChangeNotifierProvider<ContactViewModel>(
          create: (context) =>
              ContactViewModel(contactService: context.read<ContactService>()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
    );
  }
}
