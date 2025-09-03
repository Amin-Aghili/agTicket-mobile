import 'package:ag_ticket/models/enums.dart';
import 'package:flutter/material.dart';


class MyTabBar extends StatefulWidget {
  final TabController tabController;
  final List<IconData> iconData;
  const MyTabBar({
    super.key,
    required this.tabController,
    required this.iconData,
  });

  @override
  State<MyTabBar> createState() => _MyTabBarState();
}

class _MyTabBarState extends State<MyTabBar> {
  late int currentIndex;
  @override
  void initState() {
    super.initState();
    currentIndex = widget.tabController.index;
    widget.tabController.addListener(() {
      setState(() {
        currentIndex = widget.tabController.index;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return TabBar(
      labelPadding: EdgeInsets.all(8),
      labelColor: Colors.amber,
      labelStyle: TextStyle(fontSize: 10),
      unselectedLabelColor: Theme.of(context).colorScheme.surface,
      unselectedLabelStyle: TextStyle(fontSize: 8),
      indicatorColor: Colors.amber,
      dividerColor: Theme.of(context).colorScheme.surface,
      controller: widget.tabController,
      tabs: List.generate(
        EventSteps.values.length,
        (index) {
          final EventSteps step = EventSteps.values[index];

          return Center(
            child: Column(
              children: [
                Icon(
                  widget.iconData[index],
                ),
                Text(
                  step.name,
                  style: TextStyle(fontSize: 10),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_ticket/l10n/app_localizations.dart';
// import 'package:flutter_ticket/models/shop.dart';
// import 'package:flutter_ticket/utils/localized_event_steps.dart';

// class MyTabBar extends StatefulWidget {
//   final TabController tabController;
//   final List<IconData> iconData;
//   const MyTabBar({
//     super.key,
//     required this.tabController,
//     required this.iconData,
//   });

//   @override
//   State<MyTabBar> createState() => _MyTabBarState();
// }

// class _MyTabBarState extends State<MyTabBar> {
//   late int currentIndex;
//   @override
//   void initState() {
//     super.initState();
//     currentIndex = widget.tabController.index;
//     widget.tabController.addListener(() {
//       setState(() {
//         currentIndex = widget.tabController.index;
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final l10n = AppLocalizations.of(context)!;
//     return TabBar(
//       labelPadding: EdgeInsets.all(8),
//       labelColor: Colors.amber,
//       labelStyle: TextStyle(fontSize: 10),
//       unselectedLabelColor: Theme.of(context).colorScheme.surface,
//       unselectedLabelStyle: TextStyle(fontSize: 8),
//       indicatorColor: Colors.amber,
//       dividerColor: Theme.of(context).colorScheme.surface,
//       controller: widget.tabController,
//       tabs: List.generate(
//         EventSteps.values.length,
//         (index) {
//           final EventSteps step = EventSteps.values[index];

//           return Center(
//             child: Column(
//               children: [
//                 Icon(
//                   widget.iconData[index],
//                 ),
//                 Text(
//                   step.localizedStep(l10n),
//                   style: TextStyle(fontSize: 10),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
