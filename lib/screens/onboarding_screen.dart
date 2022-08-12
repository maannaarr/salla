import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:untitled2/cache_helper.dart';
import 'package:untitled2/themes.dart';
import 'package:untitled2/widgets.dart';

import 'login.dart';

class OnboardingDetails {
  String image;
  String title;
  String describtion;

  OnboardingDetails(this.title, this.describtion, this.image);
}

class ONBoardingScreen extends StatefulWidget {
  const ONBoardingScreen({Key? key}) : super(key: key);

  @override
  _ONBoardingScreenState createState() => _ONBoardingScreenState();
}

class _ONBoardingScreenState extends State<ONBoardingScreen> {
  List<OnboardingDetails> datails = [
    OnboardingDetails('OnBoarding Title 1', 'Details OnBoarding Title 1',
        'images/undraw_Setup_wizard_re_nday.png'),
    OnboardingDetails('OnBoarding Title 2', '  Details OnBoarding Title 2',
        'images/undraw_Setup_wizard_re_nday.png'),
    OnboardingDetails('OnBoarding Title 3', '  Details OnBoarding Title 3',
        'images/undraw_Setup_wizard_re_nday.png')
  ];
  PageController onboardController = PageController();
  bool isLast = false;

  void submit() {
    CacheHelper.saveData('onBoarding', true).then((value) {
      if (value) {
        navigateAndFinish(
          context,
          LoginScreen(),
        );
     print('onB ');
      }

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        shadowColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: TextButton(
                onPressed: () {
                  submit();
                 },
                child: const Text(
                  'SKIP',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0XFF67595E),
                  ),
                )),
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(5.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                  onPageChanged: (int index) {
                    if (index == datails.length - 1) {
                      setState(() {
                        isLast = true;
                      });
                    } else {
                      setState(() {
                        isLast = false;
                      });
                    }
                  },
                  controller: onboardController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: 3,
                  itemBuilder: (context, index) => builtItems(datails[index])),
            ),
          ],
        ),
      ),
    );
  }

  Widget builtItems(OnboardingDetails details) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          details.image,
          fit: BoxFit.contain,
        ),
        const SizedBox(
          height: 40,
        ),
        Text(
          details.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 35),
        ),
        const SizedBox(
          height: 10,
        ),
        Text(details.describtion),
        const SizedBox(
          height: 100,
        ),
        Row(
          children: [
            SmoothPageIndicator(
              controller: onboardController,
              count: datails.length,
              effect: ExpandingDotsEffect(
                  activeDotColor: pinky,
                  dotHeight: 10,
                  dotWidth: 10,
                  expansionFactor: 4,
                  spacing: 5),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: FloatingActionButton(
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                  onPressed: () {
                    if (isLast == true) {
                      submit();
                    } else {
                      onboardController.nextPage(
                          duration: const Duration(milliseconds: 750),
                          curve: Curves.fastLinearToSlowEaseIn);
                    }
                  }),
            ),
          ],
        ),
      ],
    );
  }
}
