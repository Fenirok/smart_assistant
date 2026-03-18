import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_assistant/view_model/theme_vm.dart';


class ModeChangingButton extends StatefulWidget {
  const ModeChangingButton({super.key});

  @override
  State<ModeChangingButton> createState() => _ModeChangingButtonState();
}

class _ModeChangingButtonState extends State<ModeChangingButton> {
  @override
  Widget build(BuildContext context) {
    final theme = Provider.of<ThemeViewModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    final w = size.width;
    final scale = w / 375;
    var isDarkMode = theme.isDark;
    return Card(
      child: ListTile(
        title: Text(
          isDarkMode ? 'Light Mode' : 'Dark Mode',
          style: TextStyle(fontSize: 16 * scale),
        ),
        trailing: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: isDarkMode ? Colors.white12 : Colors.white,
            elevation: 3,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(w * 0.08), //30
            ),
            padding: EdgeInsets.all(w * 0.015),
          ),
          onPressed: () {
            setState(() {
              isDarkMode = !isDarkMode;
            });
            theme.toggleTheme(isDarkMode);
          },
          child: Icon(
            isDarkMode ? Icons.light_mode : Icons.dark_mode,
            size: 22 * scale,
          ),
        ),
      ),
    );
  }
}
