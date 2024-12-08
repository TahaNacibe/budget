import 'package:budget/providers/data_provider.dart';
import 'package:budget/widgets/costume_button.dart';
import 'package:budget/widgets/costume_text_filed.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewDeposit extends StatefulWidget {
  const NewDeposit({super.key});

  @override
  State<NewDeposit> createState() => _NewDepositState();
}

class _NewDepositState extends State<NewDeposit> {
  //* functions
  bool? isAddAmount() {
    if (_newDepositController.text.isNotEmpty) {
      return _newDepositController.text[0] != "-";
    } else {
      return null;
    }
  }

  //* controllers
  final TextEditingController _newDepositController = TextEditingController();

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
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "New Deposit",
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontFamily: "Quick",
                        fontSize: 18),
                  ),
                ),
              ],
            ),
            costumeTextFiled(
                controller: _newDepositController,
                hint: "Enter the amount",
                isAdd: isAddAmount(),
                onChangeAccrue: (value) {
                  setState(() {});
                }),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                "New Deposit Value will be added to your Balance and then split equally into three types, Please be sure on the amount before adding",
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
                        if (_newDepositController.text.isNotEmpty) {
                          double? result =
                              double.tryParse(_newDepositController.text);
                          if (result != null) {
                            // _budgetServices.editBalance(value: result);
                            Provider.of<BudgetProvider>(context, listen: false)
                                .editBalance(value: result);
                            Navigator.of(context)
                                .pop(_newDepositController.text);
                          } else {
                            //* handle error
                          }
                        }
                      },
                      child: costumeButton(
                          title: "Apply Deposit",
                          isActive: _newDepositController.text.isNotEmpty,
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

Future<String?> showNewDepositSheet(BuildContext context) async {
  String? result = await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled:
        true, // Allows the modal to adjust height when the keyboard is visible
    builder: (context) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(15), child: const NewDeposit());
    },
  );
  return result;
}
