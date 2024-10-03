import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:hamro_smart_life/constant/app_constant.dart';
import 'package:hamro_smart_life/constant/app_screen_utils.dart';
import 'package:hamro_smart_life/constant/app_text_style.dart';
import 'package:hamro_smart_life/constant/app_urls.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_appbar.dart';
import 'package:hamro_smart_life/utils/widgets/reusable_container_widget.dart';
import 'package:hamro_smart_life/view_model/main_screen_notifier.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late MainScreenNotifier mainScreenNotifier;

  @override
  void initState() {
    mainScreenNotifier = Provider.of(context, listen: false);
    mainScreenNotifier.getCarouselBanner(context);
    super.initState();
  }

  Widget servicesHamroSmartLife(String service) {
    switch (service) {
      case "additional":
        return _buildAddional(context);
      case "calculator":
        return _buildCalculatorSection(context);
      case "quiz":
        return _buildQuizsection(context);
      case "game_note":
        return _buildGamesandNotesSection(context);
      default:
        return const SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const ReusableAppBar(
          title: "Subidha-All in One",
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Column(children: [
            _buildCarousel(),
            ...mainScreenNotifier.services
                .map((service) => servicesHamroSmartLife(service))
                .toList(),
          ]),
        ));
  }

  _buildCarousel() {
    return Consumer<MainScreenNotifier>(
      builder: (context, value, child) => value.isLoading
          ? const Center(child: CircularProgressIndicator())
          : value.carouselBanner.isEmpty
              ? const Center(child: Text("No data found"))
              : Stack(
                  children: [
                    CarouselSlider(
                      // items: value.imageList
                      //     .map((image) => _buildImageSlider(image))
                      //     .toList(),
                      items: value.carouselBanner
                          .map((banner) => _buildImageSlider(banner['image']))
                          .toList(),
                      carouselController: value.controller,
                      options: CarouselOptions(
                        height:
                            AppScreenUtils.screenWidthPercentage(context, 0.5),
                        viewportFraction:
                            1.0, // Occupy full width of the screen
                        reverse: false,
                        autoPlay: true,
                        autoPlayInterval: const Duration(seconds: 3),
                        autoPlayAnimationDuration:
                            const Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        onPageChanged: (index, reason) {
                          setState(() {
                            value.currentIndex = index;
                          });
                        },
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                    Positioned(
                      bottom: 10,
                      left: AppScreenUtils.screenWidthPercentage(context, 0.45),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(
                          value.imageList.length,
                          (index) => Container(
                            width: AppScreenUtils.screenWidthPercentage(
                                context, 0.025),
                            height: AppScreenUtils.screenHeightPercentage(
                                context, 0.02),
                            margin: const EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: value.currentIndex == index
                                  ? AppColors.primary
                                  : AppColors
                                      .white, // Adjust to your desired inactive color
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
    );
  }

  Widget _buildImageSlider(String image) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0), // Adjust as needed
            child: Image.network(
              AppUrls.baseUrl2 + image,
              width: AppScreenUtils.screenWidth(context),
              fit: BoxFit.cover,
              // loadingBuilder: (context, child, loadingProgress) {
              //   return const Center(child: CircularProgressIndicator());
              // },
            ),
            // Image.asset(
            //   image,
            //   fit: BoxFit.cover, // Adjust for desired fit
            //   width: AppScreenUtils.screenWidth(context),
            // ),
          ),
        ),
        // const Positioned(
        //   left: 0,
        //   bottom: 10,
        //   child: Padding(padding: EdgeInsets.all(13.0), child: Text("sss")),
        // ),
      ],
    );
  }

  Widget _buildAddional(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/quiz_screen');
      },
      child: ReusableContainer(
          height: AppScreenUtils.screenHeightPercentage(context, 0.10),
          width: AppScreenUtils.screenWidth(context),
          color: AppColors.teal.withOpacity(0.5),
          child: ListView.builder(
              itemCount: mainScreenNotifier.additionalServices.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ReusableContainer(
                    height: 140,
                    width: 100,
                    color: AppColors.white,
                    child: FittedBox(
                      child: Column(
                        children: [
                          Icon(
                            mainScreenNotifier.iconsServices[index],
                          ),
                          Text(
                            mainScreenNotifier.additionalServices[index],
                            style: AppTextStyles.heading5,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              })),
    );
  }

  Widget _buildQuizsection(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, '/quiz_screen');
      },
      child: ReusableContainer(
        height: AppScreenUtils.screenHeightPercentage(context, 0.15),
        width: AppScreenUtils.screenWidth(context),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Text(
                    "Let's explore \n together !",
                    style: AppTextStyles.heading4,
                  ),
                  Spacer(),
                  ReusableContainer(
                    height: 30,
                    width: 100,
                    color: AppColors.white,
                    child: FittedBox(
                      child: Text(
                        'QUIZ',
                        style: AppTextStyles.heading2,
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
            const Spacer(flex: 7),
            Padding(
              padding: const EdgeInsets.only(top: AppPadding.large),
              child: Image.asset("assets/mainscreen/award_cup.png",
                  width: 70, height: 70, fit: BoxFit.cover),
            ),
            const Spacer(flex: 1),
          ],
        ),
      ),
    );
  }

  Widget _buildCalculatorSection(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/compound_interest');
          },
          child: ReusableContainer(
            height: AppScreenUtils.screenHeightPercentage(context, 0.16),
            width: AppScreenUtils.screenWidthPercentage(context, 0.45),
            color: AppColors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Let's Calculate !",
                    style: AppTextStyles.heading5,
                  ),
                  const SizedBox(height: 4),
                  Image.asset("assets/mainscreen/calc.png",
                      width: 20, height: 20, fit: BoxFit.cover),
                  const Spacer(),
                  const ReusableContainer(
                    height: 33,
                    width: 100,
                    color: AppColors.white,
                    child: FittedBox(
                      child: Text(
                        'चक्रिय ब्याज',
                        style: AppTextStyles.heading5,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/simple_interest");
          },
          child: ReusableContainer(
            height: AppScreenUtils.screenHeightPercentage(context, 0.16),
            width: AppScreenUtils.screenWidthPercentage(context, 0.45),
            color: AppColors.lightOrange,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Let's Calculate !",
                    style: AppTextStyles.heading5,
                  ),
                  const SizedBox(height: 4),
                  Image.asset("assets/mainscreen/calc.png",
                      width: 20, height: 20, fit: BoxFit.cover),
                  const Spacer(),
                  const ReusableContainer(
                    height: 33,
                    width: 100,
                    color: AppColors.white,
                    child: FittedBox(
                      child: Text(
                        'साधारण ब्याज',
                        style: AppTextStyles.heading5,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildGamesandNotesSection(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/todo_screen');
          },
          child: ReusableContainer(
            height: AppScreenUtils.screenHeightPercentage(context, 0.16),
            width: AppScreenUtils.screenWidthPercentage(context, 0.45),
            color: AppColors.lightOrange,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Let's Explore !",
                    style: AppTextStyles.heading5,
                  ),
                  const SizedBox(height: 4),
                  Image.asset("assets/mainscreen/todo.png",
                      width: 20, height: 20, fit: BoxFit.cover),
                  const Spacer(),
                  const ReusableContainer(
                    height: 33,
                    width: 100,
                    color: AppColors.white,
                    child: FittedBox(
                      child: Text(
                        'Todo',
                        style: AppTextStyles.heading5,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, "/game_screen");
          },
          child: ReusableContainer(
            height: AppScreenUtils.screenHeightPercentage(context, 0.16),
            width: AppScreenUtils.screenWidthPercentage(context, 0.45),
            color: AppColors.lightBlue,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  const Text(
                    "Let's Play !",
                    style: AppTextStyles.heading5,
                  ),
                  const SizedBox(height: 4),
                  Image.asset(
                    "assets/mainscreen/game.png",
                    width: 20,
                    height: 20,
                    fit: BoxFit.cover,
                    color: Colors.red,
                  ),
                  const Spacer(),
                  const ReusableContainer(
                    height: 33,
                    width: 100,
                    color: AppColors.white,
                    child: FittedBox(
                      child: Text(
                        'Play',
                        style: AppTextStyles.heading5,
                      ),
                    ),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
