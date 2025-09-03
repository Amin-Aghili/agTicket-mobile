// import 'package:flutter/material.dart';
// import 'package:flutter_ticket/models/event_model.dart';
// import 'package:flutter_ticket/screens/event_management/components/my_order_tile.dart';
// import 'package:flutter_ticket/screens/event_management/components/event_details_bottom_sheet.dart';

// class OrderList extends StatelessWidget {
//   final List<EventModel> orders;
//   final int step;
//   // final Set<int> selectedIds;
//   // final void Function(int) onToggleSelection;

//   const OrderList({
//     super.key,
//     required this.orders,
//     required this.step,
//     // required this.selectedIds,
//     // required this.onToggleSelection,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return CustomScrollView(
//       physics: const AlwaysScrollableScrollPhysics(),
//       slivers: [
//         SliverList(
//           delegate: SliverChildBuilderDelegate(
//             (context, index) {
//               if (index == orders.length) return const SizedBox(height: 100);
//               final order = orders[index];
//               // final isSelected = selectedIds.contains(order.eventDetailId);
//               return MyOrderTile(
//                 endItem: index == orders.length - 1,
//                 order: order,
//                 // isSelected: isSelected,
//                 // onSelect: (step == 3)
//                 //     ? () => onToggleSelection(order.eventDetailId!)
//                 //     : null,
//                 onTap: () => showModalBottomSheet<void>(
//                   context: context,
//                   isScrollControlled: true,
//                   builder: (context) => ConstrainedBox(
//                     constraints: BoxConstraints(
//                       maxHeight: MediaQuery.of(context).size.height * 5 / 6,
//                     ),
//                     child: EventDetailsBottomSheet(order: order, step: step),
//                   ),
//                 ),
//               );
//             },
//             childCount: orders.length + 1,
//           ),
//         ),
//       ],
//     );
//   }
// }
