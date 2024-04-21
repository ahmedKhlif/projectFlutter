import 'package:flutter/material.dart';
import 'package:project/widgets/title_text.dart';
import 'package:shimmer/shimmer.dart';

class AppNameTextWidget extends StatelessWidget {
  const AppNameTextWidget({super.key, this.fontSize= 30});
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      period: const Duration(seconds: 16),
      baseColor: const Color.fromARGB(255, 20, 161, 196),
      highlightColor: Colors.purple,
      child: TitlesTextWidget(
        label: "Shopi Store ",
        fontSize: fontSize,
      ),
    );
  }
}
