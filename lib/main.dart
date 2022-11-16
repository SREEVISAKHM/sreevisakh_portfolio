import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:sreevisakh_portfolio/providers/theme.dart';
import 'package:sreevisakh_portfolio/routes/routes.dart';

void main() {
  WidgetsFlutterBinding
      .ensureInitialized();
  runApp(const ProviderScope(
      child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer(
        builder: (context, ref, _) {
      return ThemeProvider(
        initTheme: ref
                .watch(themeProvider)
                .isDarkMode
            ? MyThemes.darkTheme
            : MyThemes.lightTheme,
        child: MaterialApp(
          debugShowCheckedModeBanner:
              false,
          title: 'Sreevisakh Portfolio',
          theme: MyThemes.lightTheme,
          darkTheme: MyThemes.darkTheme,
          initialRoute: Routes.initial,
          onGenerateRoute:
              RouterGenerator
                  .generateRoute,
        ),
      );
    });
  }
}
