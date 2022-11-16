import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sreevisakh_portfolio/domain/project_model.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/about.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/carousel.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/footer.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/header.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/portfolio_stats.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/project.dart';
import 'package:sreevisakh_portfolio/presentation/home/widgets/sevice.dart';
import 'package:sreevisakh_portfolio/providers/theme.dart';
import 'package:sreevisakh_portfolio/utils/globals.dart';
import 'package:sreevisakh_portfolio/widget/custom_switch.dart';

import '../../providers/home_provider.dart';
import '../../utils/screen_helper.dart';

class Home extends ConsumerStatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home>
    with SingleTickerProviderStateMixin {
  late HomeProvider _homeProvider;
  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    _homeProvider = ref.read(homeProvider);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildPage() {
    return Stack(
      children: [
        ScrollConfiguration(
          behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                height(
                  ScreenHelper.isDesktop(context) ? 30 : 20,
                ),
                Carousel(
                  key: _homeProvider.homeKey,
                ),
                height(20),
                AboutSection(
                  key: _homeProvider.aboutKey,
                ),
                ServiceSection(
                  key: _homeProvider.servicesKey,
                ),
                SizedBox(
                  key: _homeProvider.portfolioKey,
                  height: 100.0,
                ),
                Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "My Works",
                        style: GoogleFonts.josefinSans(
                          fontWeight: FontWeight.w900,
                          fontSize: 36,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(
                        "Here are some of my Previous Work :)",
                        style: GoogleFonts.josefinSans(
                          color: Colors.grey[400],
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                    ],
                  ),
                ),
                ProjectSection(
                  projects: myProjects,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 28.0),
                  child: PortfolioStats(),
                ),
                const SizedBox(
                  height: 50.0,
                ),
                Footer(
                  key: _homeProvider.contactKey,
                )
              ],
            ),
          ),
        ),
        Header(
          themeSwitch: ThemeSwitcher(
              clipper: const ThemeSwitcherBoxClipper(),
              builder: (context) {
                return CustomSwitch(
                  value: ref.watch(themeProvider).isDarkMode,
                  onChanged: (val) {
                    ref.read(themeProvider).changeTheme(val);
                    ThemeSwitcher.of(context).changeTheme(
                        theme: ref.read(themeProvider).getCurrentTheme,
                        isReversed: false // default: false
                        );
                  },
                );
              }),
        ),
      ],
    );
  }

  SizedBox height(double height) {
    return SizedBox(
      height: height,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ThemeSwitchingArea(
      child: Scaffold(
        key: Globals.scaffoldKey,
        endDrawer: Drawer(
          child: SafeArea(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
              child: ListView.separated(
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      if (Globals.scaffoldKey.currentState != null) {
                        if (Globals.scaffoldKey.currentState!.isEndDrawerOpen) {
                          Navigator.pop(context);
                          _homeProvider.scrollBasedOnHeader(
                              HeaderRow.headerItems[index]);
                        }
                      }
                    },
                    leading: Icon(HeaderRow.headerItems[index].iconData),
                    title: Text(
                      HeaderRow.headerItems[index].title,
                      style: const TextStyle(),
                    ),
                    trailing: HeaderRow.headerItems[index].isDarkTheme != null
                        ? HeaderRow.headerItems[index].isDarkTheme!
                            ? SizedBox(
                                width: 50,
                                child: ThemeSwitcher(
                                    clipper: const ThemeSwitcherBoxClipper(),
                                    builder: (context) {
                                      return CustomSwitch(
                                        value:
                                            ref.watch(themeProvider).isDarkMode,
                                        onChanged: (val) {
                                          ref
                                              .read(themeProvider)
                                              .changeTheme(val);
                                          ThemeSwitcher.of(context).changeTheme(
                                              theme: ref
                                                  .read(themeProvider)
                                                  .getCurrentTheme,
                                              isReversed:
                                                  false // default: false
                                              );
                                        },
                                      );
                                    }),
                              )
                            : null
                        : null,
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return const SizedBox(
                    height: 10.0,
                  );
                },
                itemCount: HeaderRow.headerItems.length,
              ),
            ),
          ),
        ),
        body: _buildPage(),
      ),
    );
  }
}