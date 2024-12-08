import 'package:budget/providers/data_provider.dart';
import 'package:budget/widgets/costume_button.dart';
import 'package:budget/widgets/costume_text_filed.dart';
import 'package:budget/widgets/dashed_divider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewAction extends StatefulWidget {
  final String actionKey;
  const NewAction({required this.actionKey, super.key});

  @override
  State<NewAction> createState() => _NewActionState();
}

class _NewActionState extends State<NewAction> {
  //* instances

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
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text.rich(
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: "Quick",
                            fontSize: 18),
                        TextSpan(children: [
                          const TextSpan(text: "New Action - "),
                          TextSpan(
                              text: widget.actionKey,
                              style: const TextStyle(
                                  fontSize: 20, color: Colors.indigo))
                        ]))),
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
                        if (_newDepositController.text.isNotEmpty) {
                          double? result =
                              double.tryParse(_newDepositController.text);
                          if (result != null) {
                            Provider.of<BudgetProvider>(context, listen: false)
                                .addNewTransaction(
                                    typeKey: widget.actionKey, value: result);
                          } else {
                            //* handle error
                          }
                          Navigator.of(context).pop();
                          Navigator.of(context).pop();
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

Future<String?> showNewActionSheet(BuildContext context, String key) async {
  String? result = await showModalBottomSheet(
    backgroundColor: Colors.transparent,
    context: context,
    isScrollControlled:
        true, // Allows the modal to adjust height when the keyboard is visible
    builder: (context) {
      return ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: NewAction(
            actionKey: key,
          ));
    },
  );
  return result;
}
