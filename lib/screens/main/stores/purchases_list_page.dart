import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:lazy_retail/state/providers/stores_provider.dart';
import 'package:provider/provider.dart';

class PurchasesListPage extends StatefulWidget {
  const PurchasesListPage({Key? key}) : super(key: key);

  @override
  State<PurchasesListPage> createState() => _PurchasesListPageState();
}

class _PurchasesListPageState extends State<PurchasesListPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Provider.of<StoresProvider>(context, listen: false)
        .calculateTotalAmountSpent();
    return Scaffold(
      body: Consumer<StoresProvider>(builder: (_, provider, __) {
        return FutureBuilder(
          future: provider.purchases(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Container(
                padding: const EdgeInsets.only(top: 15),
                decoration: const BoxDecoration(color: Colors.black),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10.0,
                          vertical: 10.0,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () => ZoomDrawer.of(context)!.toggle(),
                              child: const CircleAvatar(
                                backgroundColor: Colors.white,
                                radius: 20,
                                child: Icon(
                                  Icons.menu,
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'LAZY RETAIL',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline4!
                                      .copyWith(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                Text(
                                  'Total Cost on all Items: \$${provider.totalAmountSpent}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                          color: Colors.white, fontSize: 16),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 6,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20),
                            )),
                        child: ListView.separated(
                          itemCount: provider.purchasesInDB.length,
                          separatorBuilder: (_, index) {
                            return Divider(
                              thickness: 2,
                              indent: 6,
                              endIndent: 6,
                              color: Theme.of(context).primaryColorDark,
                            );
                          },
                          itemBuilder: (context, index) {
                            final itemIndex = provider.purchasesInDB[index];
                            return ListTile(
                              title: Text(
                                itemIndex.itemName,
                                style:
                                    Theme.of(context).textTheme.headlineSmall,
                              ),
                              subtitle: Row(children: [
                                const Text('Qty'),
                                const SizedBox(width: 10),
                                Text('${itemIndex.quantity} ${itemIndex.unit}'),
                              ]),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              );
            }
          },
        );
      }),
    );
  }
}
