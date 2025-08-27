import 'package:ag_ticket/core/constants.dart';
import 'package:ag_ticket/features/events/events_screen.dart';
import 'package:ag_ticket/features/home/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

class InitScreen extends StatelessWidget {
  const InitScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      tabs: [
        PersistentTabConfig(
          screen: HomeScreen(),
          item: ItemConfig(
            icon: FaIcon(FontAwesomeIcons.house),
            title: "Home", // Events
            textStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 13),
            activeForegroundColor: agPrimaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: EventsScreen(),
          item: ItemConfig(
            icon: FaIcon(FontAwesomeIcons.ticket),
            title: "Tickets",
            textStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 13),
            activeForegroundColor: agPrimaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: Container(),
          item: ItemConfig(
            icon: FaIcon(FontAwesomeIcons.qrcode),
            title: "Scanner",
            textStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 13),
            activeForegroundColor: agPrimaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: Container(),
          item: ItemConfig(
            icon: FaIcon(FontAwesomeIcons.file),
            title: "Reports",
            textStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 13),
            activeForegroundColor: agPrimaryColor,
          ),
        ),
        PersistentTabConfig(
          screen: Container(),
          item: ItemConfig(
            icon: FaIcon(FontAwesomeIcons.user),
            title: "Profile",
            textStyle: TextStyle(fontFamily: 'NotoSans', fontSize: 13),
            activeForegroundColor: agPrimaryColor,
          ),
        ),
      ],
      navBarBuilder: (navBarConfig) => Style4BottomNavBar(
        navBarConfig: navBarConfig,
        navBarDecoration: NavBarDecoration(
          //padding: const EdgeInsets.all(10),
          color: Colors.white,
          //border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 5)],
        ),
      ),
    );
  }
}
