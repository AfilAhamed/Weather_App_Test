// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:provider/provider.dart';
import 'package:toastification/toastification.dart';
import 'package:weather_app_task/features/home/presentation/provider/app_theme_provider.dart';
import 'package:weather_app_task/features/home/presentation/provider/home_provider.dart';
import 'package:weather_app_task/features/home/presentation/view/widgets/cached_weather_banner.dart';
import 'package:weather_app_task/features/home/presentation/view/widgets/recent_searches_frame.dart';
import 'package:weather_app_task/features/home/presentation/view/widgets/weather_loading_shimmer_frame_.dart';
import 'package:weather_app_task/general/utils/app_colors.dart';
import 'package:weather_app_task/general/widgets/custom_toast_message.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController cityNameController = TextEditingController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeProvider>().searchByCityName(
        name: 'Dubai',
        onError: (error) {
          CustomToast.showToastMessage(
            msg: error,
            toastType: ToastificationType.error,
            toastColor: AppColors.toastErrorColor,
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<AppThemeProvider, HomeProvider>(
      builder: (context, themeProvider, homeProvider, child) {
        return GestureDetector(
          onTap: () {
            homeProvider.toggleRecentSearches(value: true);

            FocusScope.of(context).unfocus();
          },
          child: Scaffold(
            appBar: AppBar(
              surfaceTintColor: Colors.transparent,
              backgroundColor: Colors.transparent,

              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Switch(
                    activeThumbColor: Colors.white,
                    inactiveThumbColor: Colors.white,
                    thumbColor: const WidgetStatePropertyAll(Colors.orange),
                    inactiveTrackColor: Colors.transparent,
                    thumbIcon: WidgetStatePropertyAll(
                      themeProvider.isThemeSelected
                          ? const Icon(Icons.nights_stay)
                          : const Icon(Icons.wb_sunny, color: Colors.white),
                    ),
                    value: themeProvider.isThemeSelected,
                    onChanged: (value) {
                      themeProvider.toggleAppTheme();
                    },
                  ),
                ),
              ],
              systemOverlayStyle: themeProvider.isThemeSelected
                  ? SystemUiOverlayStyle.light
                  : SystemUiOverlayStyle.dark,
            ),
            body: LayoutBuilder(
              builder: (context, constraints) {
                return RefreshIndicator(
                  color: Colors.orange,
                  onRefresh: () async {
                    FocusScope.of(context).unfocus();

                    await homeProvider.searchByCityName(
                      name: homeProvider.weatherModel?.cityName ?? 'Dubai',
                      onError: (error) {
                        CustomToast.showToastMessage(
                          msg: error,
                          toastType: ToastificationType.error,
                          toastColor: AppColors.toastErrorColor,
                        );
                      },
                    );
                  },
                  child: SingleChildScrollView(
                    physics: const AlwaysScrollableScrollPhysics(),

                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          children: [
                            TextFormField(
                              controller: cityNameController,
                              readOnly: homeProvider.isLoading,
                              onTap: homeProvider.isLoading
                                  ? () {
                                      FocusScope.of(context).unfocus();

                                      CustomToast.showToastMessage(
                                        msg: 'Please wait a moment',
                                        toastType: ToastificationType.error,
                                        toastColor: AppColors.toastErrorColor,
                                      );
                                      return;
                                    }
                                  : () {
                                      if (homeProvider.recentSearches.isEmpty) {
                                        return;
                                      }

                                      if (homeProvider.isLoading) {
                                        return;
                                      }

                                      homeProvider.toggleRecentSearches();
                                    },
                              onFieldSubmitted: (cityName) async {
                                homeProvider.toggleRecentSearches();
                                if (cityName.isEmpty) {
                                  CustomToast.showToastMessage(
                                    msg: 'Please enter a city name to search',
                                    toastType: ToastificationType.error,
                                    toastColor: AppColors.toastErrorColor,
                                  );
                                } else {
                                  await homeProvider.searchByCityName(
                                    name: cityName,
                                    onError: (error) {
                                      CustomToast.showToastMessage(
                                        msg: error,
                                        toastType: ToastificationType.error,
                                        toastColor: AppColors.toastErrorColor,
                                      );
                                    },
                                  );
                                }
                              },
                              style: const TextStyle(color: Colors.white),
                              cursorColor: Colors.white,
                              decoration: InputDecoration(
                                hintText: 'Search by city name',
                                hintStyle: const TextStyle(
                                  color: Colors.white70,
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: themeProvider.isThemeSelected
                                      ? Colors.white
                                      : Colors.orange,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    Icons.clear,
                                    color: themeProvider.isThemeSelected
                                        ? Colors.white
                                        : Colors.orange,
                                  ),
                                  onPressed: () {
                                    cityNameController.clear();
                                  },
                                ),

                                contentPadding: const EdgeInsets.only(
                                  left: 12,
                                  right: 12,
                                  top: 12,
                                  bottom: 12,
                                ),
                                filled: true,
                                fillColor: themeProvider.isThemeSelected
                                    ? Colors.black.withOpacity(0.1)
                                    : Colors.black.withOpacity(0.7),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.white54,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            if (homeProvider.recentSearches.isNotEmpty)
                              if (homeProvider.showRecentSearches)
                                RecentSearchesDropdownFrame(
                                  recentSearches: homeProvider.recentSearches,
                                  onCitySelected: (city) async {
                                    FocusScope.of(context).unfocus();

                                    homeProvider.toggleRecentSearches();

                                    cityNameController.text = city;

                                    await homeProvider.searchByCityName(
                                      name: city,
                                      onError: (error) {
                                        CustomToast.showToastMessage(
                                          msg: error,
                                          toastType: ToastificationType.error,
                                          toastColor: AppColors.toastErrorColor,
                                        );
                                      },
                                    );
                                  },
                                ),

                            if (homeProvider.isLoading)
                              WeatherLoadingShimmerFrame(
                                isDarkMode: themeProvider.isThemeSelected,
                              )
                            else
                              Column(
                                children: [
                                  if (!homeProvider.isShowingCachedData)
                                    const Gap(30)
                                  else
                                    const Gap(10),

                                  if (homeProvider.isShowingCachedData) ...[
                                    CachedWeatherBanner(),
                                  ],

                                  Text(
                                    homeProvider.weatherModel?.cityName ??
                                        "Dubai",
                                    style: TextStyle(
                                      fontSize: 36,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  if (!homeProvider.isShowingCachedData)
                                    const Gap(20)
                                  else
                                    const Gap(10),
                                  Icon(
                                    themeProvider.isThemeSelected
                                        ? Icons.nights_stay
                                        : Icons.sunny,
                                    color: themeProvider.isThemeSelected
                                        ? Colors.white
                                        : Colors.orange,
                                    size: 250,
                                  ),
                                  const Gap(30),
                                  Text(
                                    "${homeProvider.weatherModel?.temp ?? '30'}°C",
                                    style: TextStyle(fontSize: 30),
                                  ),

                                  const Gap(30),
                                  const SizedBox(
                                    width: 50,
                                    child: Divider(thickness: 3),
                                  ),
                                  const Gap(30),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        children: [
                                          Icon(Icons.water_drop_outlined),
                                          Text('Humidity'),
                                          Text(
                                            "${homeProvider.weatherModel?.humidity ?? '0'}%",
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: VerticalDivider(thickness: 3),
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.air),
                                          Text('Wind'),
                                          Text(
                                            "${homeProvider.weatherModel?.wind ?? '0'} km/h",
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 50,
                                        child: VerticalDivider(thickness: 3),
                                      ),
                                      Column(
                                        children: [
                                          Icon(Icons.wb_cloudy_outlined),
                                          Text('Condition'),
                                          Text(
                                            homeProvider
                                                    .weatherModel
                                                    ?.condition ??
                                                'None',
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}
