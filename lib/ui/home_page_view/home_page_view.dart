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
      DoctorsScreen(),
      MoreScreen(
        onBackPressed: () {
          setState(() {
            currentPageIndex = 0;
          });
        },
      )
    ][currentPageIndex];
  }

  List<BottomNavigationBarItem> _buildDestinationList() {
    return [
      BottomNavigationBarItem(
          icon: currentPageIndex != 0
              ? ImageIcon(AssetImage(
                  'assets/icons/homeIcon.png',
                ),size: 40,)
              : ImageIcon(
                  AssetImage(
                    'assets/icons/homeIcon.png',
                  ),size: 40,
                  color: Theme.of(context).primaryColor,
                ),
          label: 'Home'),
      BottomNavigationBarItem(
        icon: currentPageIndex != 1
            ? ImageIcon(AssetImage(
                'assets/icons/reportIcon.png',
              ),size: 40,)
            : ImageIcon(
                AssetImage(
                  'assets/icons/reportIcon.png',
                ),size: 40,
                color: Color(0xFF1ce0a3),
              ),
        label: 'Report',
      ),
      BottomNavigationBarItem(
        icon: currentPageIndex != 2
            ? ImageIcon(AssetImage(
                'assets/icons/secondOpinionIcon.png',
              ),size: 40,)
            : ImageIcon(
                AssetImage(
                  'assets/icons/secondOpinionIcon.png',
                ),size: 50,
                color: Color(0xFFec652a)),
        label: 'Second',
      ),
      BottomNavigationBarItem(
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
    Color selectedItemColor = Theme.of(context).primaryColor;
    switch (currentPageIndex) {
      case 1:
        selectedItemColor = Color(0xFF1ce0a3);
        break;
      case 2:
        selectedItemColor = Color(0xFFec652a);
        break;
      default:
        selectedItemColor = Theme.of(context).primaryColor;
    }

    return BottomNavigationBar(
      showSelectedLabels: false,
      showUnselectedLabels: false,
      unselectedLabelStyle: TextStyle(overflow: TextOverflow.visible),
      type: BottomNavigationBarType.fixed,
      elevation: 5,
      selectedLabelStyle: TextStyle(overflow: TextOverflow.visible),
      onTap: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      currentIndex: currentPageIndex,
      selectedItemColor: selectedItemColor,
      items: _buildDestinationList(),
    );
  }
}
