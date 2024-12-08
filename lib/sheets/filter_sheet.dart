import 'package:flutter/material.dart';

class HistoryFilter extends StatefulWidget {
  final int activeIndex;
  final bool descended;
  final void Function(int activeIndex) onOverLay;
  final void Function(bool descended) onOrder;

  const HistoryFilter({
    required this.activeIndex,
    required this.descended,
    required this.onOrder,
    required this.onOverLay,
    Key? key,
  }) : super(key: key);

  @override
  State<HistoryFilter> createState() => _HistoryFilterState();
}

class _HistoryFilterState extends State<HistoryFilter> {
  late ValueNotifier<int> _activeIndex;
  late ValueNotifier<bool> _descended;

  @override
  void initState() {
    super.initState();
    _activeIndex = ValueNotifier(widget.activeIndex);
    _descended = ValueNotifier(widget.descended);
  }

  @override
  Widget build(BuildContext context) {
    Color scaffoldColor = Theme.of(context).scaffoldBackgroundColor;
    return Container(
      padding: const EdgeInsets.all(12),
      color: scaffoldColor,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          titleRow("Overlay"),
          ValueListenableBuilder<int>(
            valueListenable: _activeIndex,
            builder: (context, value, child) {
              return Column(
                children: [
                  optionItem(title: "All", isActive: value == 0, index: 0),
                  optionItem(title: "Deposit", isActive: value == 1, index: 1),
                  optionItem(title: "Withdraw", isActive: value == 2, index: 2),
                ],
              );
            },
          ),
          titleRow("Order"),
          ValueListenableBuilder<bool>(
            valueListenable: _descended,
            builder: (context, value, child) {
              return Column(
                children: [
                  optionItem(
                    title: "Reverse",
                    isActive: value,
                    index: null,
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget optionItem({
    required String title,
    required bool isActive,
    required int? index,
  }) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: () {
        if (index != null) {
          _activeIndex.value = index; // Update local state
          widget.onOverLay(index); // Notify parent
        } else {
          // Toggle order state correctly
          final newOrder = !isActive; // Determine the new order state
          if (newOrder != _descended.value) {
            _descended.value = newOrder; // Update local state
            widget.onOrder(newOrder); // Notify parent
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 18,
                fontFamily: "Quick",
              ),
            ),
            if (isActive) const Icon(Icons.done),
          ],
        ),
      ),
    );
  }

  Widget titleRow(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 20,
          fontFamily: "Quick",
        ),
      ),
    );
  }
}

void showFilterBottomSheet(
    BuildContext context,
    int index,
    bool descended,
    void Function(int activeIndex) onOverLay,
    void Function(bool descended) onOrder) {
  showModalBottomSheet(
    context: context,
    backgroundColor: Colors.transparent,
    builder: (context) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: HistoryFilter(
          activeIndex: index,
          descended: descended,
          onOrder: onOrder,
          onOverLay: onOverLay,
        ),
      );
    },
  );
}
