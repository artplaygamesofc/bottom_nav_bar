import 'package:flutter/material.dart';

class BottomNavBar extends StatelessWidget {
  /// Current index that is selected
  final int selectedIndex;

  /// Height of `BottomNavBar`
  final num? height;

  /// Background Color of `BottomNavBar`
  final Color backgroundColor;

  /// Color of `BottomNavBarItem` when it is selected
  final Color selectedColor;

  /// List of `BottomNavBarItems` to display
  final List<BottomNavBarItem> items;

  /// Fires this callback whenever a `BottomNavBarItem` is tapped
  /// Use this callback to update the `selectedIndex`
  final ValueChanged<int> onTap;

  /// Creates a `BottomNavBar` that displays a list of `BottomNavBarItem` along with
  /// added animations whenever a `BottomNavBarItem` is clicked
  const BottomNavBar({
    Key? key,
    required this.selectedIndex,
    this.height,
    required this.backgroundColor,
    required this.selectedColor,
    required this.items,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemWidth = MediaQuery.of(context).size.width / items.length + 20;

    return Container(
      height: height?.toDouble() ?? 60.0,
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: items.asMap().entries.map((entry) {
          var item = entry.value;
          var color = item.color ?? selectedColor;
          var icon = item.icon;
          var label = item.label;

          int index = entry.key;
          bool isSelected = selectedIndex == index;

          return Flexible(
            child: InkWell(
              onTap: () => onTap(index),
              child: RepaintBoundary(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: isSelected ? itemWidth : 50,
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  margin: const EdgeInsets.only(top: 10, bottom: 10),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: isSelected ? color : Colors.transparent,
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Icon(
                        icon,
                        size: 24,
                        color: isSelected
                            ? Theme.of(context).iconTheme.color
                            : color,
                      ),
                      isSelected
                          ? Expanded(
                              flex: 2,
                              child: Text(
                                label,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            )
                          : Container()
                    ],
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class BottomNavBarItem {
  /// Key of `BottomNavBarItem`.
  /// This will be the key of the specific `BottomNavBarItem` shown in `BottomNavBar`
  final Key? key;

  /// Icon of `BottomNavBarItem`.
  /// This will be the icon shown in each `BottomNavBarItem`
  final IconData icon;

  /// Label of `BottomNavBarItem`.
  final String label;

  /// Color of `BottomNavBarItem` during **light mode** when it is selected.
  /// This will be the active color of icon, title, and background
  final Color? color;

  /// This contains information about the item that `BottomNavBar` has to display
  BottomNavBarItem({
    this.key,
    required this.icon,
    required this.label,
    this.color,
  });
}
