import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/config.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'main_screen.dart';
import 'menu_screen.dart';
import 'stores/about_us_page.dart';
import 'stores/help_page.dart';
import 'stores/notifications_page.dart';
import 'stores/payment_page.dart';
import 'stores/promos_page.dart';
import 'stores/purchases_list_page.dart';
import 'stores/rate_us_page.dart';
import 'widgets/menu_items.dart' as item;

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);
  static const String id = 'welcome_screen';

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _zoomDrawerController = ZoomDrawerController();
  item.MenuItem currentItem = item.MenuItems.purchases;

  @override
  Widget build(BuildContext context) {
    return ZoomDrawer(
      controller: _zoomDrawerController,
      style: DrawerStyle.defaultStyle,
      menuScreen: Builder(builder: (context) {
        return MenuScreen(
          currentItem: currentItem,
          onSelectedItem: (item) {
            setState(() {
              currentItem = item;
            });
            ZoomDrawer.of(context)!.close();
          },
        );
      }),
      mainScreen: getScreen(),
      menuScreenWidth: MediaQuery.of(context).size.width,
      borderRadius: 40.0,
      showShadow: true,
      angle: -16,
      drawerShadowsBackgroundColor: Colors.grey[300]!,
      slideWidth: MediaQuery.of(context).size.width * .65,
      openCurve: Curves.fastOutSlowIn,
      closeCurve: Curves.bounceIn,
      androidCloseOnBackTap: true,
      menuBackgroundColor: Colors.indigo,
    );
  }

  Widget getScreen() {
    switch (currentItem) {
      case item.MenuItems.purchases:
        return const PurchasesListPage();
      case item.MenuItems.payment:
        return const PaymentsPage();
      case item.MenuItems.promos:
        return const PromosPage();
      case item.MenuItems.notifications:
        return const NotificationsPage();
      case item.MenuItems.help:
        return const HelpPage();
      case item.MenuItems.aboutUs:
        return const AboutUsPage();
      case item.MenuItems.rateUs:
        return const RateUsPage();
      default:
        return const PurchasesListPage();
    }
  }
}
