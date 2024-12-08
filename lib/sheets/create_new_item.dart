import 'package:budget/models/shop_item.dart';
import 'package:budget/providers/data_provider.dart';
import 'package:budget/widgets/costume_button.dart';
import 'package:budget/widgets/costume_text_filed.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAction extends StatefulWidget {
  final String actionKey;
  final String parentClass;
  final bool isEdit;
  final String? itemName;
  final String? itemValue;
  final ShopItem? item;
  final int? index;
  const NewAction(
      {required this.actionKey,
      required this.parentClass,
      this.isEdit = false,
      this.itemName,
      this.index,
      this.itemValue,
      this.item,
      super.key});

  @override
  State<NewAction> createState() => _NewActionState();
}

class _NewActionState extends State<NewAction> {
  //* functions
  bool? isAddAmount() {
    if (_newItemPriceController.text.isNotEmpty &&
        _newItemNameController.text.isNotEmpty) {
      return _newItemPriceController.text[0] != "-";
    } else {
      return null;
    }
  }

  //* controllers
  final TextEditingController _newItemPriceController = TextEditingController();
  final TextEditingController _newItemNameController = TextEditingController();

  //* init
  @override
  void initState() {
    if (widget.isEdit) {
      _newItemNameController.text = widget.itemName ?? "";
      _newItemPriceController.text = widget.itemValue ?? "0.00";
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Container(
        color: scaffoldColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.close)),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quick",
                            fontSize: 18),
                        TextSpan(children: [
                          const TextSpan(text: "New Item - "),
                          TextSpan(
                              text: widget.actionKey,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.indigo))
                        ]))),
              ],
            ),
            costumeTextFiled(
                controller: _newItemNameController,
                hint: "Item Name",
                isOnlyNumbers: false,
                isAdd: null,
                onChangeAccrue: (value) {
                  setState(() {});
                }),
            costumeTextFiled(
                controller: _newItemPriceController,
                hint: "Enter the amount",
                isAdd: null,
                onChangeAccrue: (value) {
                  setState(() {});
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "Please confirm all your data before proceeding, like action type and amount",
                style: TextStyle(
                    fontWeight: FontWeight.w400,
                    fontFamily: "Quick",
                    fontSize: 14),
              ),
            ),
            dashedDivider(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: costumeButton(
                        title: "Cancel",
                        isActive: true,
                        color: Colors.grey.withOpacity(.9)),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        if (_newItemPriceController.text.isNotEmpty &&
                            _newItemNameController.text.isNotEmpty) {
                          double? result =
                              double.tryParse(_newItemPriceController.text);
                          if (result != null) {
                            if (widget.isEdit) {
                              Provider.of<BudgetProvider>(context,
                                      listen: false)
                                  .updateShopItem(
                                      index: widget.index!,
                                      item: widget.item!,
                                      newName: _newItemNameController.text,
                                      newValue: result,
                                      listKey: widget.parentClass);
                            } else {
                              Provider.of<BudgetProvider>(context,
                                      listen: false)
                                  .addNewShopItem(
                                      listKey: widget.parentClass,
                                      item: ShopItem(
                                          name: _newItemNameController.text,
                                          type: widget.actionKey,
                                          price: result,
                                          parentClass: widget.parentClass));
                            }
                          } else {
                            //* handle error
                          }
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
                        }
                      },
                      child: costumeButton(
                          title: widget.isEdit ? "Update Item" : "Add Item",
                          isActive: _newItemNameController.text.isNotEmpty &&
                              _newItemPriceController.text.isNotEmpty,
                          color: Colors.indigo.withOpacity(.9)),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<String?> showNewItemSheet(
    BuildContext context, String key, String parentClass,
    {String? name,
    String? value,
    int? index,
    ShopItem? item,
    bool isEdit = false}) async {
  String? result = await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled:
        true, // Allows the modal to adjust height when the keyboard is visible
    builder: (context) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: NewAction(
            parentClass: parentClass,
            isEdit: isEdit,
            itemName: name,
            index: index,
            item: item,
            itemValue: value,
            actionKey: key,
          ));
    },
  );
  return result;
}
