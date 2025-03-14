import 'package:flutter/material.dart';
import 'package:moticar/utils/iterator_helper.dart';

class DesignSpacing {
  static const outerEdgeInsets = 16.0;
  static const cardEdgeInset = 8.0;
  static const itemSpacingCompact = 8.0;
  static const itemSpacingLoose = 16.0;
  static const itemSpacingSparse = 32.0;
  static const compactWidth = 320.0;
  static const elevation = 4.0;
  static const itemSpacingVeryLoose = 24.0;

  // Spacing
  static const spacerXSmall = 4.0;
  static const spacerSmall = 8.0;
  static const spacerMedium = 12.0;
  static const spacerLarge = 20.0;
  static const spacerXLarge = 32.0;
  // Radii
  static const radiiFull = 999;
  static const radiiXLarge = 64.0;
  static const radiiLarge = 40.0;
  static const radiiMedium = 12.0;
  static const radiiSmall = 8.0;
  static const radiiXSmall = 4.0;
}

class _Constants {
  static const dividerColor = Color(0x14212121);
}

class HorizontalDivider extends StatelessWidget {
  const HorizontalDivider({super.key});
  @override
  Widget build(BuildContext context) {
    return const Divider(
      indent: 0,
      endIndent: 0,
      height: 1.0,
      color: _Constants.dividerColor,
    );
  }
}

List<Widget> addSpacingBetween(
    {required List<Widget> children,
      double? verticalSpacing,
      double? horizontalSpacing}) {
  final spacing = List.generate(
      children.length - 1,
          (index) => SizedBox(
        height: verticalSpacing,
        width: horizontalSpacing,
      ));
  return zip(children, spacing).toList();
}
