import 'package:ag_ticket/ui/components/my_container.dart';
import 'package:flutter/material.dart';

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    this.onTap,
  });
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: MyContainer(
        border: true,
        child: Row(
          children: [
            Image.asset(
              "assets/images/profile_pic.png",
              height: 38,
            ),
            const Icon(Icons.keyboard_arrow_down),
          ],
        ),
      ),
    );
  }
}
