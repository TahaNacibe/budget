import 'package:flutter/material.dart';

//* vars
OutlineInputBorder borderDecoration = OutlineInputBorder(
    borderRadius: BorderRadius.circular(15),
    borderSide: const BorderSide(color: Colors.transparent));

Widget costumeTextFiled(
    {required TextEditingController controller,
    required String hint,
    bool isOnlyNumbers = true,
    bool isReadOnly = false,
    int? maxLength,
    required bool? isAdd,
    Widget trailing = const SizedBox.shrink(),
    required void Function(String value) onChangeAccrue}) {
  return Padding(
    padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8),
    child: TextField(
      controller: controller,
      onChanged: onChangeAccrue,
      readOnly: isReadOnly,
      maxLength: maxLength,
      keyboardType: isOnlyNumbers
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      decoration: InputDecoration(
          border: borderDecoration,
          focusedBorder: borderDecoration,
          enabledBorder: borderDecoration,
          label: Text(
(isAdd == null
                    ? ""
                    : isAdd
                        ? "Deposit"
                        : "Withdraw")
                ,
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontFamily: "Quick",
                color: isAdd != null
                    ? isAdd
                        ? Colors.green
                        : Colors.red
                    : null,
                fontSize: 16),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.always,
          filled: true,
          fillColor: Colors.grey.withOpacity(.1),
          contentPadding: const EdgeInsets.only(left: 8),
          hintText: hint,
          hintStyle: const TextStyle(
              fontFamily: "Quick", fontWeight: FontWeight.w400, fontSize: 12),
              suffixIcon: trailing
              ),
    ),
  );
}
