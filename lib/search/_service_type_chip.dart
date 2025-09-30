import 'package:flutter/material.dart';

class ServiceTypeChip extends StatelessWidget {
  final String type;
  const ServiceTypeChip({required this.type, super.key});

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color fg = Colors.white;
      switch (type.toUpperCase()) {
        case 'FULL':
          bg = const Color(0xFF64B5F6); // łagodny niebieski
          break;
        case 'TRYM':
          bg = const Color(0xFF81C784); // łagodny zielony
          break;
        default:
          bg = Colors.grey.shade300;
          fg = Colors.black;
      }
      return Chip(
        label: Text(
          type,
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 11, letterSpacing: 0.2),
        ),
        backgroundColor: bg,
        labelStyle: TextStyle(color: fg),
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: -2),
        visualDensity: const VisualDensity(horizontal: -3, vertical: -3),
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        side: BorderSide.none,
      );
  }
}
