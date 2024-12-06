import 'package:flutter/material.dart';

/// Barry
/// @date 2024/7/25
/// describe:
class BaseScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final List<Widget>? actions;

  const BaseScaffold({
    required this.body,
    this.title,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kToolbarHeight,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: Navigator.of(context).pop,
                  icon: Icon(Icons.arrow_back_ios, color: Colors.white),
                ),
              ),
              Center(
                child: Text(
                  title ?? "",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (actions != null) ...actions!,
                    SizedBox(width: 30),
                  ],
                ),
              ),
            ],
          ),
        ),
        Expanded(child: body),
      ],
    );
  }
}
