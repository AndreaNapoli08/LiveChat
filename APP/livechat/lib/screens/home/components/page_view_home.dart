import 'package:flutter/material.dart';
import 'package:livechat/screens/home/components/preview_ranking.dart';
import 'package:livechat/screens/home/components/preview_steps.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../models/auth/auth_user.dart';
import 'chats_preview.dart';

class PageViewHome extends StatefulWidget {
  const PageViewHome({super.key, required this.authUser});

  final AuthUser authUser;

  @override
  State<PageViewHome> createState() => _PageViewHomeState();
}

class _PageViewHomeState extends State<PageViewHome> {
  final int totalPages = 3;

  final PageController pageController = PageController(
    initialPage: 0,
    viewportFraction: 0.9,
  );

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 8, bottom: 3.0),
          child: SmoothPageIndicator(
            controller: pageController,
            count: 3,
            effect: const WormEffect(),
            onDotClicked: (index) => pageController.animateToPage(
              index,
              duration: const Duration(milliseconds: 300),
              curve: Curves.ease,
            ),
          ),
        ),
        SizedBox(
          height: 390,
          child: PageView.builder(
            scrollDirection: Axis.horizontal,
            controller: pageController,
            itemBuilder: (BuildContext context, int index) {
              int pageIndex = index % totalPages;
              if (pageIndex == 0) {
                return PreviewRanking(authUser: widget.authUser);
              } else if (pageIndex == 1) {
                return const PreviewSteps();
              } else if (pageIndex == 2) {
                return ChatsPreview(authUser: widget.authUser);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }
}
