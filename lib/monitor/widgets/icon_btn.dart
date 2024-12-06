import 'package:flutter/material.dart';

/// Barry
/// @date 2024/7/25
/// describe:
class IconBtn extends StatelessWidget {
  final VoidCallback? onTap;
  final IconData icon;

  const IconBtn(
    this.icon, {
    super.key,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 30,
        alignment: Alignment.center,
        child: Icon(icon, color: Colors.white),
      ),
      onTap: onTap,
    );
  }
}
