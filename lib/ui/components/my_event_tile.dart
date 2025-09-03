import 'package:ag_ticket/models/event_model.dart';
import 'package:ag_ticket/ui/components/my_container.dart';
import 'package:flutter/material.dart';

class MyEventTile extends StatelessWidget {
  const MyEventTile({
    super.key,
    required this.onTap,
    required this.event,
  });
  final VoidCallback onTap;
  final EventModel event;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: MyContainer(
        verticalMargin: 8,
        horizontalMargin: 0,
        verticalPadding: 0,
        horizontalPadding: 0,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(8.0),
                    bottomLeft: Radius.circular(8.0),
                  ),
                  // child: Image.network(
                  //   event.image ?? '',
                  //   height: 100,
                  //   fit: BoxFit.cover,
                  //   errorBuilder: (context, error, stackTrace) =>
                  //       const Icon(Icons.error),
                  // ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        event.eventName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        "${event.startDate ?? ''} ${event.endDate != null ? '---- ${event.endTime}' : ''}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        event.location ?? 'ٔNo Location',
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                      Text(
                        "${event.capacity ?? 0} / ${event.minAge ?? 0}",
                        style: const TextStyle(
                          color: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Positioned(
              bottom: 8,
              right: 8,
              child: Text(
                '${event.price?.toStringAsFixed(2) ?? '0.00'} TL',
                style: const TextStyle(
                  color: Colors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
