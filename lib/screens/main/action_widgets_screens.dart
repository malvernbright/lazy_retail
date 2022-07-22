import 'package:flutter/material.dart';

import 'stores/add_purchases_page.dart';

class ActionWidgetsScreen extends StatelessWidget {
  const ActionWidgetsScreen({Key? key}) : super(key: key);

  static const String id = 'action_widgets_screen';

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: [
        buildActionCard(
          icon: Icons.store,
          cardText: 'ADD ITEM',
          iconTextColor: Colors.white,
          cardColor: Colors.red,
          onTap: () {
            showDialog(
                context: context,
                builder: (_) {
                  return const Dialog(
                    child: AddPurchasesScreen(),
                  );
                });
          },
        ),
        buildActionCard(
          icon: Icons.point_of_sale_outlined,
          cardText: 'RECORD A SALE',
          iconTextColor: Colors.white,
          cardColor: Theme.of(context).primaryColor,
          onTap: () {},
        ),
      ],
    );
  }

  Widget buildActionCard(
      {required IconData icon,
      required String cardText,
      required Color iconTextColor,
      required Color cardColor,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        margin: const EdgeInsets.all(10),
        color: cardColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        elevation: 2,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 35,
              color: iconTextColor,
            ),
            Text(
              cardText,
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: iconTextColor),
            ),
          ],
        ),
      ),
    );
  }
}
