import 'package:flutter/material.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sreevisakh_portfolio/utils/colors.dart';

import '../presentation/demo/demo.dart';
import '../presentation/home/home.dart';

class Routes {
  static const String initial = "/";
  static const String demos = "/demos";
}

class RouterGenerator {
  static Route<dynamic> generateRoute(
      RouteSettings settings) {
    switch (settings.name) {
      case Routes.initial:
        return _GeneratePageRoute(
            widget: const Home(),
            routeName: settings.name);

      case Routes.demos:
        return _GeneratePageRoute(
            widget: const Demo(),
            routeName: settings.name);

      default:
        return _GeneratePageRoute(
            widget: const Home(),
            routeName: settings.name);
    }
  }
}

class _GeneratePageRoute
    extends PageRouteBuilder {
  final Widget? widget;
  final String? routeName;
  _GeneratePageRoute(
      {this.routeName, this.widget})
      : super(
            settings: RouteSettings(
                name: routeName),
            pageBuilder: (BuildContext
                    context,
                Animation<double>
                    animation,
                Animation<double>
                    secondaryAnimation) {
              return widget ??
                  const SizedBox();
            },
            transitionDuration:
                const Duration(
                    milliseconds: 500),
            transitionsBuilder:
                (BuildContext context,
                    Animation<double>
                        animation,
                    Animation<double>
                        secondaryAnimation,
                    Widget child) {
              return SlideTransition(
                  position: Tween<
                              Offset>(
                          begin:
                              const Offset(
                                  1.0,
                                  0.0),
                          end: Offset
                              .zero)
                      .animate(
                          animation),
                  child: ResponsiveWrapper
                      .builder(
                          ClampingScrollWrapper
                              .builder(
                                  context,
                                  child),
                          defaultScale:
                              true,
                          breakpoints: [
                            const ResponsiveBreakpoint
                                    .resize(
                                450,
                                name:
                                    MOBILE),
                            const ResponsiveBreakpoint
                                    .resize(
                                800,
                                name:
                                    TABLET),
                            const ResponsiveBreakpoint
                                    .resize(
                                1000,
                                name:
                                    TABLET),
                            const ResponsiveBreakpoint
                                    .resize(
                                1200,
                                name:
                                    DESKTOP),
                            const ResponsiveBreakpoint
                                    .resize(
                                2460,
                                name:
                                    '4k'),
                          ],
                          background:
                              Container(
                            color:
                                kBackgroundColor,
                          )));
            });
}
