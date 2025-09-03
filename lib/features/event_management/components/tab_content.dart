// import 'package:ag_ticket/features/event_management/components/event_management_list.dart';
// import 'package:ag_ticket/models/enums.dart';
// import 'package:ag_ticket/models/event_model.dart';
// import 'package:flutter/material.dart';

// // import 'event_list.dart';

// class TabContent extends StatelessWidget {
//   final TabController tabController;
//   final List<EventModel> event;

//   final bool isOrderLoading;
//   // final Set<int> selectedIds;
//   // final void Function(int) onToggleSelection;

//   const TabContent({
//     super.key,
//     required this.tabController,
//     required this.event,
//     required this.isOrderLoading,
//     // required this.selectedIds,
//     // required this.onToggleSelection,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return TabBarView(
//       controller: tabController,
//       children: List.generate(
//         EventSteps.values.length,
//         (index) => _buildEmptyState(isOrderLoading),
//       ),
//     );
//   }

//   Widget _buildEmptyState(bool isLoading) => CustomScrollView(
//         physics: const AlwaysScrollableScrollPhysics(),
//         slivers: [
//           SliverFillRemaining(
//             hasScrollBody: false,
//             child: Center(
//                 child: isLoading
//                     ? const CircularProgressIndicator()
//                     : EventManagementList()),
//           ),
//         ],
//       );
// }
