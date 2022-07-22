import 'package:flutter/material.dart';

import '../menu_screen.dart';

class MenuItem {
  final String title;
  final IconData icon;
  const MenuItem({required this.title, required this.icon});
}

class MenuItems {
  static const purchases =
      MenuItem(title: 'Purchases', icon: Icons.store_mall_directory);
  static const payment = MenuItem(title: 'Payment', icon: Icons.payment);
  static const promos = MenuItem(title: 'Promo', icon: Icons.card_giftcard);
  static const notifications =
      MenuItem(title: 'Notifications', icon: Icons.notifications);
  static const help = MenuItem(title: 'Help', icon: Icons.help);
  static const aboutUs = MenuItem(title: 'About Us', icon: Icons.info_outline);
  static const rateUs = MenuItem(title: 'Rate Us', icon: Icons.star_border);

  static const all = <MenuItem>[
    purchases,
    payment,
    promos,
    notifications,
    help,
    aboutUs,
    rateUs
  ];
}
