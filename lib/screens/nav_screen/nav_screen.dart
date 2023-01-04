import 'package:dagda/screens/nav_screen/nav_bar_item.dart';
import 'package:dagda/widgets/buttons/filled_button.dart';
import 'package:dagda/widgets/tabbar/custom_tab_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class NavScreen extends StatefulWidget {
  NavScreen({Key? key, required this.child}) : super(key: key);
  final Widget child;

  @override
  State<NavScreen> createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  static const tabs = [
    ScaffoldWithNavBarTabItem(
        initialLocation: '/home',
        icon: Icon(Icons.home_rounded),
        label: 'Home'),
    ScaffoldWithNavBarTabItem(
        initialLocation: '/search',
        icon: Icon(Icons.search_rounded),
        label: 'Search'),
    ScaffoldWithNavBarTabItem(
        initialLocation: '/profile',
        icon: Icon(Icons.person_rounded),
        label: 'Profile'),
  ];

  int get _currentIndex => _locationToTabIndex(GoRouter.of(context).location);

  int _locationToTabIndex(String location) {
    final index =
        tabs.indexWhere((t) => location.startsWith(t.initialLocation));
    // if index not found (-1), return 0
    return index < 0 ? 0 : index;
  }

  // callback used to navigate to the desired tab
  void _onItemTapped(BuildContext context, int tabIndex) {
    if (tabIndex != _currentIndex) {
      // go to the initial location of the selected tab (by index)
      context.go(tabs[tabIndex].initialLocation);
    }
  }

  @override
  Widget build(BuildContext context) {
    final double additionalBottomPadding =
        MediaQuery.of(context).padding.bottom;
    return LayoutBuilder(builder: (BuildContext, boxConstraints) {
      if (boxConstraints.maxWidth < 600) {
        return Scaffold(
          body: widget.child,
          floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.black,
              onPressed: () {},
              tooltip: 'Add',
              elevation: 10,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(20))),
              child: const Icon(Icons.add)),
          bottomNavigationBar: DefaultTabController(
            length: tabs.length,
            child: ConstrainedBox(
              constraints: BoxConstraints(
                  minHeight:
                      kBottomNavigationBarHeight + additionalBottomPadding),
              child: CustomTabBar(
                selectedIndex: _currentIndex,
                onTap: (index) => _onItemTapped(context, index),
                tabs: tabs,
              ),
            ),
          ),
        );
      } else if (boxConstraints.maxWidth < 1200) {
        return Scaffold(
            body: Row(children: [
          NavigationRail(
              labelType: NavigationRailLabelType.all,
              elevation: 10,
              backgroundColor: Colors.white,
              leading: Column(
                children: [
                  const SizedBox(height: 20),
                  FloatingActionButton(
                      backgroundColor: Colors.black,
                      onPressed: () {},
                      tooltip: 'Add',
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: const Icon(Icons.add)),
                ],
              ),
              selectedIconTheme: const IconThemeData(color: Colors.black),
              unselectedIconTheme:
                  const IconThemeData(color: Colors.grey, opacity: 0.5),
              selectedLabelTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
              unselectedLabelTextStyle: const TextStyle(
                  color: Colors.grey, fontWeight: FontWeight.bold),
              destinations: tabs
                  .map((e) => NavigationRailDestination(
                      icon: e.icon, label: Text(e.label!)))
                  .toList(),
              selectedIndex: _currentIndex,
              onDestinationSelected: (index) => _onItemTapped(context, index)),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: widget.child)
        ]));
      } else {
        return Scaffold(
            body: Row(children: [
          NavigationRail(
            extended: true,
            labelType: NavigationRailLabelType.none,
            elevation: 10,
            backgroundColor: Colors.white,
            leading: Text(
              AppLocalizations.of(context)!.appName,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 34),
            ),
            selectedIconTheme: const IconThemeData(color: Colors.black),
            unselectedIconTheme:
                const IconThemeData(color: Colors.grey, opacity: 0.5),
            selectedLabelTextStyle: const TextStyle(
                color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16),
            unselectedLabelTextStyle: const TextStyle(
                color: Colors.grey, fontWeight: FontWeight.bold),
            destinations: tabs
                .map((e) => NavigationRailDestination(
                    icon: e.icon,
                    label: Text(e.label!),
                    padding: EdgeInsets.all(2.0)))
                .toList(),
            selectedIndex: _currentIndex,
            onDestinationSelected: (index) => _onItemTapped(context, index),
            trailing: Padding(
              padding: const EdgeInsets.only(top: 24.0),
              child: FloatingActionButton.extended(
                onPressed: () {},
                label: Text('Add Dag'),
                icon: const Icon(Icons.add),
                backgroundColor: Colors.black,
                elevation: 10,
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10))),
              ),
            ),
          ),
          const VerticalDivider(thickness: 1, width: 1),
          Expanded(child: widget.child)
        ]));
      }
    });
  }
}
