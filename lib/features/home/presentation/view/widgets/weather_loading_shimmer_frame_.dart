// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:shimmer/shimmer.dart';

class WeatherLoadingShimmerFrame extends StatelessWidget {
  final bool isDarkMode;

  const WeatherLoadingShimmerFrame({super.key, required this.isDarkMode});

  Widget shimmerBox({
    required double height,
    required double width,
    double radius = 12,
  }) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  Widget weatherInfoItem() {
    return Column(
      children: [
        shimmerBox(height: 25, width: 25, radius: 50),
        const Gap(8),
        shimmerBox(height: 14, width: 70),
        const Gap(8),
        shimmerBox(height: 18, width: 50),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final baseColor = isDarkMode ? Colors.grey.shade800 : Colors.grey.shade400;

    final highlightColor = isDarkMode
        ? Colors.grey.shade600
        : Colors.grey.shade200;

    final shimmerItemColor = isDarkMode ? Colors.grey.shade700 : Colors.white;

    return Shimmer.fromColors(
      baseColor: baseColor,
      highlightColor: highlightColor,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Theme(
            data: Theme.of(context).copyWith(dividerColor: shimmerItemColor),
            child: Column(
              children: [
                const Gap(35),

                Container(
                  height: 40,
                  width: 180,
                  decoration: BoxDecoration(
                    color: shimmerItemColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const Gap(30),

                Container(
                  height: 250,
                  width: 250,
                  decoration: BoxDecoration(
                    color: shimmerItemColor,
                    shape: BoxShape.circle,
                  ),
                ),

                const Gap(35),

                Container(
                  height: 35,
                  width: 120,
                  decoration: BoxDecoration(
                    color: shimmerItemColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const Gap(35),

                Container(width: 50, height: 3, color: shimmerItemColor),

                const Gap(35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    weatherInfoItem(),
                    SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        thickness: 2,
                        color: shimmerItemColor,
                      ),
                    ),
                    weatherInfoItem(),
                    SizedBox(
                      height: 50,
                      child: VerticalDivider(
                        thickness: 2,
                        color: shimmerItemColor,
                      ),
                    ),
                    weatherInfoItem(),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
