import 'package:flutter/material.dart';
import 'package:second_opinion_app/ui/home/home.dart';

import '../more/more.dart';
import '../reports/report.dart';
import '../second_opinion/doctors.dart';


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
      body: _buildCurrentIndexWidget(),
    );
  }

  Widget _buildCurrentIndexWidget() {
    return <Widget>[
      HomeScreen(),
      ReportsScreen(
        onBackPressed: () {
          setState(() {
            currentPageIndex = 0;
          });
        },
      ),
      DoctorsScreen(

      ),
      MoreScreen(
        onBackPressed: () {
          setState(() {
            currentPageIndex = 0;
          });
        },
      )
    ][currentPageIndex];
  }

  List<Widget> _buildDestinationList() {
    return <Widget>[
      NavigationDestination(
        icon: currentPageIndex != 0 ? Icon(Icons.home_max_rounded) : Icon(Icons.home_max_rounded,color: Theme.of(context).primaryColor,),
        label: 'Home',
      ),
      NavigationDestination(
        icon: currentPageIndex != 1
            ? ImageIcon(AssetImage(
                'assets/icons/unselected_report.png',
              ))
            : ImageIcon(
                AssetImage(
                  'assets/icons/unselected_report.png',
                ),
                color: Theme.of(context).primaryColor,
              ),
        label: 'Report',
      ),
      NavigationDestination(
        icon: currentPageIndex != 2
            ? ImageIcon(AssetImage(
                'assets/icons/unselected_opinion.png',
              ))
            : ImageIcon(
                AssetImage(
                  'assets/icons/unselected_opinion.png',
                ),
                color: Theme.of(context).primaryColor),
        label: 'Second Opinion',
      ),
      NavigationDestination(
        icon: currentPageIndex != 3
            ? ImageIcon(AssetImage(
                'assets/icons/More_unselected.png',
              ))
            : ImageIcon(
                AssetImage(
                  'assets/icons/More_unselected.png',
                ),
                color: Theme.of(context).primaryColor),
        label: 'More',
      ),
    ];
  }

  Widget _buildBottomNavBar() {
    return NavigationBar(
        elevation: 5,
        onDestinationSelected: (int index) {
          setState(() {
            currentPageIndex = index;
          });
        },
        selectedIndex: currentPageIndex,
        destinations: _buildDestinationList());
  }
}
