import 'package:flutter/material.dart';

class ResponsiveWebFrame extends StatelessWidget {
  final Widget child;

  const ResponsiveWebFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          return Scaffold(
            backgroundColor: const Color(0xFF1C1D22),
            body: Center(
              child: Container(
                width: 440,
                height: 860,
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF5F5F7),
                  borderRadius: BorderRadius.circular(32),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 15),
                    ),
                  ],
                  border: Border.all(color: const Color(0xFF2C2D35), width: 8),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: child,
                ),
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
