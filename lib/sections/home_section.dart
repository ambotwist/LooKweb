import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:website/theme/app_theme.dart';

class HomeSection extends StatelessWidget {
  const HomeSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: AppTheme.lightTheme.colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.only(top: 60),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 50),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 600,
                    child: RichText(
                      text: TextSpan(
                        text: 'Fashion tailored ',
                        style: TextStyle(
                          fontFamily: 'Museum',
                          fontSize: 52,
                          height: 1.1,
                        ),
                        children: <TextSpan>[
                          TextSpan(
                            text: 'uniquely',
                            style: TextStyle(),
                          ),
                          TextSpan(
                            text: ' to you',
                            style: TextStyle(),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: 600,
                    child: Text(
                      'Find clothing tailored to you instantly with our AI-powered App that learns from your style.',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w300,
                        height: 1.2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 70,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: SizedBox(
                              height: 70,
                              width: 160,
                              child: SvgPicture.asset(
                                  'assets/icons/Download_on_the_app_store.svg'),
                            )),
                        const SizedBox(width: 20),
                        IconButton(
                            onPressed: () {},
                            icon: SizedBox(
                              child: Image.asset(
                                  'assets/icons/get_it_on_google_play.png'),
                            )),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: MediaQuery.of(context).size.width > 900
                  ? Image.asset(
                      'assets/images/homepage_image_row.png',
                      fit: BoxFit.fitHeight,
                      alignment: Alignment.centerLeft,
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: Image.asset(
                        'assets/images/website_home_image.png',
                        fit: BoxFit.fitHeight,
                        alignment: Alignment.center,
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
