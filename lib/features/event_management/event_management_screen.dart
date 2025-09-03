// import 'package:ag_ticket/features/event_management/components/add_event.dart';
// import 'package:ag_ticket/features/event_management/components/header.dart';
// import 'package:ag_ticket/features/event_management/components/my_tab_bar.dart';
// import 'package:ag_ticket/models/enums.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:ag_ticket/providers/event_provider.dart';

// import 'components/tab_content.dart';

// class EventManagementScreen extends ConsumerStatefulWidget {
//   const EventManagementScreen({super.key});

//   @override
//   ConsumerState<EventManagementScreen> createState() =>
//       _EventManagementScreenState();
// }

// class _EventManagementScreenState extends ConsumerState<EventManagementScreen>
//     with SingleTickerProviderStateMixin, WidgetsBindingObserver {
//   late final TabController _tabController;
//   late bool _isOrderLoading;
//   late bool _showBottomNavBar;

//   static const _tabIcons = [
//     Icons.all_inbox,
//     Icons.flash_on,
//     Icons.history,
//     Icons.cancel_outlined,
//     Icons.edit_note_outlined,
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _tabController =
//         TabController(length: EventSteps.values.length, vsync: this)
//           ..addListener(_applyTabFilter);
//     _isOrderLoading = false;
//     WidgetsBinding.instance.addObserver(this);
//     WidgetsBinding.instance.addPostFrameCallback((_) => _applyTabFilter());
//   }

//   void _applyTabFilter() {
//     final eventNotifier = ref.read(eventProvider.notifier);
//     final index = _tabController.index;

//     // Apply filter based on tab
//     switch (EventSteps.values[index]) {
//       case EventSteps.all:
//         eventNotifier.setFilter(null);
//         break;
//       case EventSteps.active:
//         eventNotifier.setFilter('Available');
//         break;
//       case EventSteps.soldOut:
//         eventNotifier.setFilter('Sold Out');
//         break;
//       case EventSteps.canceled:
//         eventNotifier.setFilter('Canceled');
//         break;
//       case EventSteps.draft:
//         eventNotifier.setFilter(null);
//         break;
//     }
//   }

//   void _showAddEventSheet() {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (context) => ConstrainedBox(
//         constraints: BoxConstraints(
//           maxHeight: MediaQuery.of(context).size.height * 5 / 6,
//         ),
//         child: const AddEvent(),
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     _tabController.removeListener(_applyTabFilter);
//     _tabController.dispose();
//     super.dispose();
//   }

//   @override
//   void didChangeMetrics() {
//     setState(() {
//       _showBottomNavBar = View.of(context).viewInsets.bottom == 0;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final eventState = ref.watch(eventProvider);

//     return Stack(
//       children: [
//         Column(
//           children: [
//             Header(
//                 // onSearchChanged: (query) {
//                 //   ref.read(eventProvider.notifier).setSearchQuery(query);
//                 // },
//                 ),
//             MyTabBar(
//               tabController: _tabController,
//               iconData: _tabIcons,
//             ),
//             Expanded(
//               child: RefreshIndicator(
//                 onRefresh: () async =>
//                     ref.read(eventProvider.notifier).refresh(),
//                 child: TabContent(
//                   tabController: _tabController,
//                   event: eventState.filteredEvents,
//                   isOrderLoading: _isOrderLoading,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         if (_showBottomNavBar)
//           Positioned(
//             bottom: 100.0,
//             right: 16.0,
//             child: FloatingActionButton(
//               onPressed: _showAddEventSheet,
//               child: const Icon(Icons.add),
//             ),
//           ),
//       ],
//     );
//   }
// }
