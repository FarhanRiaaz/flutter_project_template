import 'package:flutter/material.dart';

import 'package:second_opinion_app/ui/landing.dart';


class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  int _currentPage = 0;

  final PageController _pageController = PageController(initialPage: 0);

  void _nextPage() {
    if (_currentPage == 2) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
      return;
    }
    _pageController.nextPage(
      duration: Duration(milliseconds: 500),
      curve: Curves.ease,
    );
    setState(() {
      _currentPage++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LandingPage()));
            },
            child: Text(
              'Skip',
              style: TextStyle(color: Colors.grey),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: Colors.black,
        onPressed: _nextPage,
        child: Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/intro_background/introBackground1.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: PageView(
          controller: _pageController,
          onPageChanged: (int page) {
            setState(() {
              _currentPage = page;
            });
          },
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: SizedBox(
                    height: 293,
                    child: Image.asset('assets/images/intro/intro1.png'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Welcome to Second Opinion app. We will provide you assistance in all health related problems',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PageIndicator(
                        count: 3,
                        currentIndex: _currentPage,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: SizedBox(
                    height: 293,
                    child: Image.asset('assets/images/intro/intro2.png'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Welcome to Second Opinion app. We will provide you assistance in all health related problems',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PageIndicator(
                        count: 3,
                        currentIndex: _currentPage,
                      )
                    ],
                  ),
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 80,
                ),
                Center(
                  child: SizedBox(
                    height: 293,
                    child: Image.asset('assets/images/intro/intro3.png'),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome!',
                        textAlign: TextAlign.left,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Welcome to Second Opinion app. We will provide you assistance in all health related problems',
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      PageIndicator(
                        count: 3,
                        currentIndex: _currentPage,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class PageIndicator extends StatelessWidget {
  final int count;
  final int currentIndex;
  final Color selectedColor;
  final Color unselectedColor;

  const PageIndicator({
    Key? key,
    required this.count,
    required this.currentIndex,
    this.selectedColor = Colors.blue,
    this.unselectedColor = Colors.grey,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(count, (index) {
        return Container(
          width: 8.0,
          height: 8.0,
          margin: EdgeInsets.symmetric(horizontal: 4.0),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == currentIndex ? selectedColor : unselectedColor,
          ),
        );
      }),
    );
  }
}
