import 'package:flutter/material.dart';

class DrawerItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onTap;
  const DrawerItem({super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 20,
            ),
          ),
          Icon(
            icon,
            size: 30,
          ),
        ],
      ),
    );
  }
}
