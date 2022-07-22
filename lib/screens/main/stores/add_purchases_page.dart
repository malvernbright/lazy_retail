import 'package:flutter/material.dart';
import 'package:lazy_retail/custom_widgets/custom_text_form_field.dart';
import 'package:lazy_retail/models/purchase.dart';
import 'package:lazy_retail/state/providers/stores_provider.dart';
import 'package:provider/provider.dart';

class AddPurchasesScreen extends StatefulWidget {
  const AddPurchasesScreen({Key? key}) : super(key: key);

  static const String id = 'add_purchases';

  @override
  State<AddPurchasesScreen> createState() => _AddPurchasesScreenState();
}

class _AddPurchasesScreenState extends State<AddPurchasesScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _unitBuyingPriceController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.4,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Consumer<StoresProvider>(
        builder: (_, provider, __) {
          return Form(
            key: _formKey,
            child: ListView(
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'ADD ITEM',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    buildTextFormField(
                      hintText: 'Item name',
                      controller: _itemNameController,
                      fillColor: Colors.white,
                      borderHintFocusTextColor: Colors.black,
                    ),
                    buildTextFormField(
                      hintText: 'Item description',
                      controller: _descriptionController,
                      fillColor: Colors.white,
                      borderHintFocusTextColor: Colors.black,
                    ),
                    buildTextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      hintText: 'Quantity',
                      controller: _quantityController,
                      fillColor: Colors.white,
                      borderHintFocusTextColor: Colors.black,
                    ),
                    buildTextFormField(
                      hintText: 'Unit',
                      controller: _unitController,
                      fillColor: Colors.white,
                      borderHintFocusTextColor: Colors.black,
                    ),
                    buildTextFormField(
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      hintText: 'Unit buying price',
                      controller: _unitBuyingPriceController,
                      fillColor: Colors.white,
                      borderHintFocusTextColor: Colors.black,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        MaterialButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          shape: const StadiumBorder(),
                          child: const Text('CANCEL'),
                        ),
                        MaterialButton(
                          color: Theme.of(context).primaryColorDark,
                          onPressed: () {
                            _formKey.currentState!.save();
                            if (_formKey.currentState!.validate()) {
                              double totalCost = double.parse(
                                      _quantityController.text) *
                                  double.parse(_unitBuyingPriceController.text);
                              Purchase purchase = Purchase(
                                itemName: _itemNameController.text,
                                description: _descriptionController.text,
                                quantity:
                                    double.parse(_quantityController.text),
                                unit: _unitController.text,
                                buyingPrice: double.parse(
                                    _unitBuyingPriceController.text),
                                totalCost: totalCost,
                                datePurchased: DateTime.now().toIso8601String(),
                              );
                              provider.recordPurchase(purchase).then((value) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(
                                      '${_itemNameController.text} saved successfully!'),
                                ));
                              }).then((value) => Navigator.pop(context));
                            }
                          },
                          shape: const StadiumBorder(),
                          child: const Text('ADD ITEM'),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// StoresProvider