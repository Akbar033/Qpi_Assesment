import 'package:flutter/material.dart';

class RealisticCard extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  final IconData icon;
  final Color color;

  const RealisticCard({
    super.key,
    required this.title,
    required this.onTap,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),

          // 👇 THIS is what makes it realistic
          boxShadow: const [
            // dark shadow (bottom right)
            BoxShadow(
              color: Colors.black26,
              offset: Offset(4, 4),
              blurRadius: 8,
            ),

            // light shadow (top left)
            BoxShadow(
              color: Colors.white,
              offset: Offset(-4, -4),
              blurRadius: 8,
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(icon, size: 26, color: Colors.blue),
            const SizedBox(width: 16),
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16),
          ],
        ),
      ),
    );
  }
}
