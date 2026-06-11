import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CachedWeatherBanner extends StatelessWidget {
  const CachedWeatherBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Gap(10),

        Icon(Icons.cloud_off, color: Colors.orange),
        Gap(10),
        Text(
          'Showing cached weather data',
          style: TextStyle(fontWeight: FontWeight.w400, fontSize: 12),
        ),
      ],
    );
  }
}
