import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_assistant/view/widgets/bottom_nav_bar_items.dart';

import '../../view_model/theme_vm.dart';

class BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemSelected;

  const BottomNavBar({
    super.key,
    required this.selectedIndex,
    required this.onItemSelected,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeProvider = Provider.of<ThemeViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final bottomPadding = MediaQuery.of(context).padding.bottom;
    final double navBarHeight = size.height * 0.073; // 8.5% of screen height
    final double iconContainerSize = size.width * 0.18; // 15% of screen width
    final double iconSize = size.width * 0.1; // 7% of screen width
    // final double horizontalPadding = size.width * 0.1; // 5% of screen width
    // final double verticalPadding = size.height * 0.02; // 1.5% of screen height

    return Container(
      height: navBarHeight + bottomPadding,
      decoration: BoxDecoration(
        color: theme.colorScheme.background,
        border: Border(top: BorderSide(color: theme.colorScheme.background)),
      ),
      child: Padding(
        padding: EdgeInsets.only(bottom: bottomPadding),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            BottomNavBarItem(
              selectedIcon: Icon(Icons.home, color: theme.colorScheme.primary, size: iconSize,),
              unselectedIcon: Icon(Icons.home, color: theme.colorScheme.onSurfaceVariant, size: iconSize,),
              index: 0,
              selectedIndex: selectedIndex,
              iconContainerSize: iconContainerSize,
              onTap: () => onItemSelected(0),
            ),

            BottomNavBarItem(
              selectedIcon: Icon(Icons.chat, color: theme.colorScheme.primary,size: iconSize,),
              unselectedIcon: Icon(Icons.chat, color: theme.colorScheme.onSurfaceVariant, size: iconSize,),
              index: 1,
              selectedIndex: selectedIndex,
              //selectedColor: Color(0xFF0092A6),
              iconContainerSize: iconContainerSize,
              onTap: () => onItemSelected(1),
            ),

            BottomNavBarItem(
              selectedIcon: Icon(Icons.history, color: theme.colorScheme.primary,size: iconSize,),
              unselectedIcon: Icon(Icons.history, color: theme.colorScheme.onSurfaceVariant, size: iconSize,),
              index: 2,
              selectedIndex: selectedIndex,
              iconContainerSize: iconContainerSize,
              onTap: () => onItemSelected(2),
            ),
          ],
        ),
      ),
    );
  }
}
