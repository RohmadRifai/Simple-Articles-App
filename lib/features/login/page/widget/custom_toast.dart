import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomToast extends StatelessWidget {
  final String message;
  const CustomToast({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
          color: Theme.of(context).errorColor,
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: [
          const Icon(Icons.warning_rounded, color: Colors.white),
          const SizedBox(width: 12),
          Expanded(
            child: Text(message, style: const TextStyle(color: Colors.white)),
          )
        ],
      ),
    );
  }
}
