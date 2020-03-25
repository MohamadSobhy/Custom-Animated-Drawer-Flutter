import 'package:flutter/material.dart';

import 'branches_page.dart';
import 'dashboard_page.dart';
import 'funds_transfer_page.dart';
import 'messages_page.dart';
import 'settings_page.dart';
import 'utility_bills_page.dart';

class CustomAnimatedDrawerScreen extends StatefulWidget {
  @override
  _CustomAnimatedDrawerScreenState createState() =>
      _CustomAnimatedDrawerScreenState();
}

class _CustomAnimatedDrawerScreenState extends State<CustomAnimatedDrawerScreen>
    with SingleTickerProviderStateMixin {
  double pageContentRadius = 0.0;
  bool isCollapsed = false;
  double screenWidth;
  double screenHeight;
  String _pageContentTitle = 'My Cards';
  PageContent _currentPageContent = PageContent.dashboard;
  Animation<double> _scaleAnimation;
  AnimationController _scaleController;

  @override
  void initState() {
    _scaleController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_scaleController);
    super.initState();
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    screenWidth = screenSize.width;
    screenHeight = screenSize.height;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            _buildDrawerSlider(),
            _buildPageContent(),
          ],
        ),
      ),
    );
  }

  Widget _buildPageContent() {
    return AnimatedPositioned(
      duration: Duration(milliseconds: 300),
      left: isCollapsed ? screenWidth * 0.4 : 0.0,
      top: 0.0,
      bottom: 0.0,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          width: screenWidth,
          height: screenHeight,
          child: Material(
            elevation: 8.0,
            color: Color(0xFF343442), //Color(0xFF2D2D39),
            borderRadius: BorderRadius.circular(pageContentRadius),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        onTap: () {
                          setState(() {
                            isCollapsed = !isCollapsed;
                            if (!isCollapsed) {
                              pageContentRadius = 0.0;
                              _scaleController.reverse();
                            } else {
                              pageContentRadius = 20.0;
                              _scaleController.forward();
                            }
                          });
                        },
                        child: Icon(
                          Icons.menu,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        _pageContentTitle,
                        style: Theme.of(context).textTheme.title,
                      ),
                      InkWell(
                        splashColor: Theme.of(context).primaryColor,
                        onTap: () {
                          if (_currentPageContent != PageContent.settings) {
                            setState(() {
                              _pageContentTitle = 'Settings';
                              _currentPageContent = PageContent.settings;
                            });
                          }
                        },
                        child: Icon(
                          Icons.settings,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                _buildPageContentBody(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPageContentBody() {
    Widget pageBody;
    switch (_currentPageContent) {
      case PageContent.dashboard:
        pageBody = DashboardPage();
        break;
      case PageContent.messages:
        pageBody = MessagesPage();
        break;
      case PageContent.utilityBills:
        pageBody = UtilityBillsPage();
        break;
      case PageContent.fundsTransfer:
        pageBody = FundsTransferPage();
        break;
      case PageContent.branches:
        pageBody = BranchesPage();
        break;
      case PageContent.settings:
        pageBody = SettingsPage();
        break;
      default:
        pageBody = Center(
          child: Text('Page Not Found'),
        );
    }
    return Expanded(
      child: pageBody,
    );
  }

  Widget _buildDrawerSlider() {
    return Container(
      width: screenWidth,
      height: screenHeight,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          _buildProfileImageAvatar(),
          SizedBox(
            height: 20.0,
          ),
          Container(
            margin: const EdgeInsets.only(left: 15.0),
            child: Text(
              'Mohammad Sobhy',
              style: Theme.of(context).textTheme.title,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15.0, top: 5.0, bottom: 20.0),
            child: Text(
              'Toukh, Al Qalyubiyah',
              style: Theme.of(context)
                  .textTheme
                  .body1
                  .copyWith(color: Color(0xFF6D6E80)),
            ),
          ),
          _buildSDrawerliderItem(
            title: 'Dashboard',
            icon: Icons.dashboard,
            isSelected: _currentPageContent == PageContent.dashboard,
            onTap: _openDashboard,
          ),
          _buildSDrawerliderItem(
            title: 'Messages',
            icon: Icons.mail_outline,
            isSelected: _currentPageContent == PageContent.messages,
            onTap: _openMessages,
          ),
          _buildSDrawerliderItem(
            title: 'Utility Bills',
            icon: Icons.receipt,
            isSelected: _currentPageContent == PageContent.utilityBills,
            onTap: _openUtilityBills,
          ),
          _buildSDrawerliderItem(
            title: 'Funds Transfer',
            icon: Icons.swap_horiz,
            isSelected: _currentPageContent == PageContent.fundsTransfer,
            onTap: _openFundsTransfer,
          ),
          _buildSDrawerliderItem(
            title: 'Branches',
            icon: Icons.home,
            isSelected: _currentPageContent == PageContent.branches,
            onTap: _openBranches,
          ),
        ],
      ),
    );
  }

  Widget _buildProfileImageAvatar() {
    return Container(
      margin: EdgeInsets.only(left: 15.0),
      child: Align(
        alignment: Alignment.topLeft,
        child: CircleAvatar(
          radius: 50,
          backgroundColor: Color(0xFF1F2537),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(50),
            child: Container(
              width: 100.0,
              height: 100.0,
              child: Image.asset(
                'assets/images/profile_image.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSDrawerliderItem(
      {String title, IconData icon, bool isSelected, onTap}) {
    return InkWell(
      splashColor: Theme.of(context).primaryColor,
      onTap: onTap ?? () {},
      child: Padding(
        padding: const EdgeInsets.only(
          left: 15.0,
          top: 8.0,
          bottom: 8.0,
        ),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: isSelected ? Colors.white : Color(0xFF6D6E80),
            ),
            SizedBox(
              width: 8.0,
            ),
            Text(
              title,
              style: isSelected
                  ? Theme.of(context).textTheme.title
                  : Theme.of(context)
                      .textTheme
                      .title
                      .copyWith(color: Color(0xFF6D6E80)),
            ),
          ],
        ),
      ),
    );
  }

  void _openDashboard() {
    if (_currentPageContent != PageContent.dashboard) {
      _currentPageContent = PageContent.dashboard;
      _pageContentTitle = 'My Cards';
    }
    setState(() {
      isCollapsed = false;
      pageContentRadius = 0.0;
    });
    _scaleController.reverse();
  }

  void _openMessages() {
    if (_currentPageContent != PageContent.messages) {
      _currentPageContent = PageContent.messages;
      _pageContentTitle = 'Messages';
    }
    setState(() {
      isCollapsed = false;
      pageContentRadius = 0.0;
    });
    _scaleController.reverse();
  }

  void _openUtilityBills() {
    if (_currentPageContent != PageContent.utilityBills) {
      _currentPageContent = PageContent.utilityBills;
      _pageContentTitle = 'Utility Bills';
    }
    setState(() {
      isCollapsed = false;
      pageContentRadius = 0.0;
    });
    _scaleController.reverse();
  }

  void _openFundsTransfer() {
    if (_currentPageContent != PageContent.fundsTransfer) {
      _currentPageContent = PageContent.fundsTransfer;
      _pageContentTitle = 'Funds Transfer';
    }
    setState(() {
      isCollapsed = false;
      pageContentRadius = 0.0;
    });

    _scaleController.reverse();
  }

  void _openBranches() {
    if (_currentPageContent != PageContent.branches) {
      _currentPageContent = PageContent.branches;
      _pageContentTitle = 'Branches';
    }
    setState(() {
      isCollapsed = false;
      pageContentRadius = 0.0;
    });

    _scaleController.reverse();
  }
}

enum PageContent {
  dashboard,
  messages,
  utilityBills,
  settings,
  fundsTransfer,
  branches,
}
