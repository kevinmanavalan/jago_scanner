import 'package:flutter/material.dart';

class MemberCard extends StatelessWidget {
  final String name;
  final String relation;
  // final String imagePath;

  const MemberCard({
    super.key,
    required this.name,
    required this.relation,
    // required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130, // Fixed width for each card
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            // Card content
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: Colors.grey[100], borderRadius: BorderRadius.circular(12)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 30,
                    // backgroundImage: AssetImage(imagePath),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 2),
                  Text(relation, style: TextStyle(fontSize: 12, color: Colors.grey[600])),
                ],
              ),
            ),
            // Close button
            Positioned(
              top: 5,
              right: 5,
              child: InkWell(
                onTap: () {},
                customBorder: const CircleBorder(), // Makes the tap ripple circular
                child: Container(
                  padding: const EdgeInsets.all(2.0), // Small padding around the icon
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.grey.shade700, width: 1),
                  ),
                  child: Icon(Icons.close, size: 16.0, color: Colors.grey[700]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
