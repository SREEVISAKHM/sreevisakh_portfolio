import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:sreevisakh_portfolio/domain/status_model.dart';

import '../../../utils/app_constants.dart';
import '../../../utils/colors.dart';
import '../../../utils/screen_helper.dart';

List<StatusModel> status = [
  StatusModel(animatedCounterValue: 15, text: 'Client Projects'),
  StatusModel(animatedCounterValue: 15, text: 'Git Projects'),
  StatusModel(animatedCounterValue: 10, text: 'Arduino Projects')
];

class PortfolioStats extends StatelessWidget {
  const PortfolioStats({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      child: ScreenHelper(
        desktop: _buildUi(kDesktopMaxWidth, context),
        tablet: _buildUi(kTabletMaxWidth, context),
        mobile: _buildUi(getMobileMaxWidth(context), context),
      ),
    );
  }

  Widget _buildUi(double width, BuildContext context) {
    return SizedBox(
      child: ResponsiveWrapper(
        maxWidth: width,
        minWidth: width,
        defaultScale: false,
        child: LayoutBuilder(
            builder: (BuildContext context, BoxConstraints constraint) {
          return Wrap(
            spacing: 20,
            runSpacing: 20,
            children: status.map((e) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                // width: ScreenHelper.isMobile(context)
                //     ? constraint.maxWidth / 2.0 - 10
                //     : (constraint.maxWidth / 4.0 - 20),
                child: Wrap(children: [
                  AnimatedCounter(value: e.animatedCounterValue),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    e.text,
                    style: const TextStyle(
                      fontSize: 16.0,
                      color: kCaptionColor,
                    ),
                  ),
                ]),
              );
            }).toList(),
          );
        }),
      ),
    );
  }
}

class AnimatedCounter extends StatelessWidget {
  final int value;

  const AnimatedCounter({Key? key, required this.value}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: 0, end: value),
      duration: const Duration(seconds: 2),
      builder: (context, value, child) => Text(
        "$value +",
        style: GoogleFonts.josefinSans(
          fontWeight: FontWeight.w700,
          fontSize: 32.0,
        ),
      ),
    );
  }
}
