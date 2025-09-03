// import 'package:ag_ticket/features/event_management/components/edit_event.dart';
// import 'package:ag_ticket/providers/event_provider.dart';
// import 'package:ag_ticket/ui/components/my_event_tile.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';

// class EventManagementList extends ConsumerWidget {
//   const EventManagementList({super.key});

//   final bool isLoading = false;

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final eventState = ref.watch(eventProvider);
//     final eventList = eventState.filteredEvents;

//     if (eventList.isEmpty) {
//       return Center(
//         child: Text("W D F"),
//       );
//     }
//     return Column(
//       children: [
//         for (var event in eventList) ...[
//           MyEventTile(
//             event: event,
//             onTap: () => showModalBottomSheet<void>(
//               context: context,
//               isScrollControlled: true,
//               builder: (context) => ConstrainedBox(
//                 constraints: BoxConstraints(
//                   maxHeight: MediaQuery.of(context).size.height * 5 / 6,
//                 ),
//                 child: EditEvent(event: event),
//                 // child: EditEvent(event: event),
//               ),
//             ),
//           ),
//           if (event == eventList.last) const SizedBox(height: 100),
//         ],
//       ],
//     );
//   }
// }
