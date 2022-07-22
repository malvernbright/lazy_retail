import 'package:flutter/material.dart';
import 'package:lazy_retail/screens/main/action_widgets_screens.dart';
import 'widgets/menu_items.dart' as item;

class MenuScreen extends StatelessWidget {
  const MenuScreen(
      {Key? key, required this.currentItem, required this.onSelectedItem})
      : super(key: key);

  final item.MenuItem currentItem;
  final ValueChanged<item.MenuItem> onSelectedItem;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData.dark(),
      child: Scaffold(
        backgroundColor: Colors.indigo,
        body: SafeArea(
            child: Padding(
          padding:
              EdgeInsets.only(top: MediaQuery.of(context).size.height * .1),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: item.MenuItems.all.map(buildMenuItem).toList(),
              ),
              buildMenuButton(
                  onPressed: () => Navigator.popAndPushNamed(
                        context,
                        ActionWidgetsScreen.id,
                      ),
                  buttonText: 'LOGOUT',
                  iconData: Icons.logout)
            ],
          ),
        )),
      ),
    );
  }

  Widget buildMenuItem(item.MenuItem menuItem) => ListTileTheme(
        selectedColor: Colors.white,
        child: ListTile(
          selectedTileColor: Colors.black26,
          selected: currentItem == menuItem,
          minLeadingWidth: 20,
          leading: Icon(menuItem.icon),
          title: Text(menuItem.title),
          onTap: () => onSelectedItem(menuItem),
        ),
      );

  Widget buildMenuButton(
      {context,
      required VoidCallback onPressed,
      required String buttonText,
      required IconData iconData}) {
    return Builder(builder: (context) {
      return Container(
        width: MediaQuery.of(context).size.width * .4,
        padding: const EdgeInsets.all(2.0),
        margin: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        child: TextButton.icon(
          onPressed: onPressed,
          label: Text(
            buttonText,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          icon: Icon(iconData, size: 30, color: Colors.white),
        ),
      );
    });
  }
}
