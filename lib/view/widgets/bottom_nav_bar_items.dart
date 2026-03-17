import 'package:flutter/material.dart';

class BottomNavBarItem extends StatefulWidget {
  final Widget selectedIcon;
  final Widget unselectedIcon;
  final int index;
  final int selectedIndex;
  //final Color selectedColor;
  final double iconContainerSize;
  final VoidCallback? onTap;

  const BottomNavBarItem({
    super.key,
    required this.selectedIcon,
    required this.unselectedIcon,
    required this.index,
    required this.selectedIndex,
    //required this.selectedColor,
    required this.iconContainerSize,
    this.onTap,
  });

  @override
  State<BottomNavBarItem> createState() => _BottomNavBarItemState();
}

class _BottomNavBarItemState extends State<BottomNavBarItem> {
  @override
  Widget build(BuildContext context) {
    bool isSelected = widget.selectedIndex == widget.index;

    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
        width: widget.iconContainerSize,
        height: widget.iconContainerSize,
        child: isSelected
            ? widget.selectedIcon
            : widget.unselectedIcon,
      ),
    );
  }
}
