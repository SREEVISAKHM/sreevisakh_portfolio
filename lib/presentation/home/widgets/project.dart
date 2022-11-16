import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../domain/project_model.dart';
import '../../../providers/theme.dart';
import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_helper.dart';

class ProjectSection extends StatelessWidget {
  final List<Project> projects;
  const ProjectSection({Key? key, required this.projects}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }

  Widget _buildUi(double width, BuildContext context) {
    return ScrollConfiguration(
      behavior: ScrollConfiguration.of(context).copyWith(scrollbars: false),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: projects
              .map(
                (e) => Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: _buildProject(width, e),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
  // Widget _buildUi(double width, BuildContext context) {
  //   return SizedBox(
  //     height: 200,
  //     width: MediaQuery.of(context).size.width,
  //     child: ListView.builder(
  //         shrinkWrap: true,
  //         scrollDirection: Axis.horizontal,
  //         itemBuilder: (context, index) {
  //           return Padding(
  //             padding: const EdgeInsets.all(8.0),
  //             child: _buildProject(width, projects[index]),
  //           );
  //         }),
  //   );
  // }

  Center _buildProject(double width, Project project) {
    return Center(
      child: LayoutBuilder(builder: (context, constraints) {
        return SizedBox(
          child: Consumer(builder: (context, ref, _) {
            return Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: ref.watch(themeProvider).isDarkMode
                    ? const Color.fromARGB(75, 12, 12, 7)
                    : Colors.grey[100],
                borderRadius: BorderRadius.circular(5),
              ),
              child: Flex(
                direction: ScreenHelper.isMobile(context)
                    ? Axis.vertical
                    : Axis.horizontal,
                children: [
                  // SizedBox(
                  //   width: ScreenHelper.isMobile(context)
                  //       ? width * 0.9
                  //       : width * 0.46,
                  //   child: Container(
                  //     color: Colors.blue,
                  //     width: constraints.maxWidth > 720.0 ? null : 350.0,
                  //     height: 250,
                  //   ),
                  // ),
                  const SizedBox(
                    width: 20,
                    height: 20,
                  ),
                  SizedBox(
                    width: ScreenHelper.isMobile(context)
                        ? width * 0.9
                        : width * 0.45,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 15.0,
                        ),
                        Text(
                          project.title!,
                          style: GoogleFonts.josefinSans(
                            fontWeight: FontWeight.w900,
                            height: 1.3,
                            fontSize: 28.0,
                          ),
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Text(
                          project.description!,
                          style: const TextStyle(
                            color: kCaptionColor,
                            height: 1.5,
                            fontSize: 15.0,
                          ),
                        ),
                        const SizedBox(
                          height: 20.0,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            );
          }),
        );
      }),
    );
  }
}
