import 'package:flutter/material.dart';
import 'package:second_opinion_app/ui/home/home.dart';

import '../more/more.dart';
import '../reports/report.dart';
import '../second_opinion/second_opinion.dart';

class PageViewScreen extends StatefulWidget {
  const PageViewScreen({super.key});

  @override
  State<PageViewScreen> createState() => _PageViewScreenState();
}

class _PageViewScreenState extends State<PageViewScreen> {
  int currentPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        bottomNavigationBar: _buildBottomNavBar(),
        body: _buildCurrentIndexWidget());
  }

  Widget _buildCurrentIndexWidget() {
    return <Widget>[
      HomeScreen(),
      ReportsScreen(onBackPressed: (){
        setState(() {
          currentPageIndex=0;
        });
      },),
      SecondOpinionScreen(onBackPressed: (){
        setState(() {
          currentPageIndex=0;
        });
      },),
      MoreScreen(onBackPressed: () {setState(() {
        currentPageIndex=0;
      });  },)
    ][currentPageIndex];
  }


  List<Widget> _buildDestinationList(){

    return   <Widget>[
      NavigationDestination(
        icon: Icon(Icons.home_max_rounded),
        label: 'Home',
      ),
      NavigationDestination(
        icon: Icon(Icons.event_note_rounded),
        label: 'Report',
      ),
      NavigationDestination(
        icon: Icon(Icons.health_and_safety_outlined),
        label: 'Second Opinion',
      ),
      NavigationDestination(
        icon: Icon(Icons.more_horiz_rounded),
        label: 'More',
      ),
    ];

  }


  Widget _buildBottomNavBar(){
    return NavigationBar(
        backgroundColor: Colors.white,
        elevation: 5,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: _buildDestinationList()
    );

  }
}
