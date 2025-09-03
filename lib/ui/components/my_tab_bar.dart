import 'package:flutter/material.dart';

class MyTabBar<T> extends StatefulWidget {
  final TabController tabController;
  final List<T> enumValues;
  final List<IconData> icons;

  const MyTabBar({
    super.key,
    required this.tabController,
    required this.enumValues,
    required this.icons,
  }) : assert(enumValues.length == icons.length);

  @override
  State<MyTabBar<T>> createState() => _MyTabBarState<T>();
}

class _MyTabBarState<T> extends State<MyTabBar<T>> {
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
      labelPadding: const EdgeInsets.all(8),
      labelColor: Colors.amber,
      labelStyle: const TextStyle(fontSize: 10),
      unselectedLabelColor: Theme.of(context).colorScheme.surface,
      unselectedLabelStyle: const TextStyle(fontSize: 8),
      indicatorColor: Colors.amber,
      dividerColor: Theme.of(context).colorScheme.surface,
      controller: widget.tabController,
      tabs: List.generate(widget.enumValues.length, (index) {
        final T step = widget.enumValues[index];
        return Column(
          children: [
            Icon(widget.icons[index]),
            Text(
              step.toString(),
              style: const TextStyle(fontSize: 10),
            ),
          ],
        );
      }),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_ticket/l10n/app_localizations.dart';

// class MyTabBar<T extends Enum> extends StatefulWidget {
//   final TabController tabController;
//   final List<IconData> iconData;
//   final List<T> enumValues;
//   final String Function(T, AppLocalizations) localizedLabel;

//   const MyTabBar({
//     super.key,
//     required this.tabController,
//     required this.iconData,
//     required this.enumValues,
//     required this.localizedLabel,
//   });

//   @override
//   State<MyTabBar<T>> createState() => _MyTabBarState<T>();
// }

// class _MyTabBarState<T extends Enum> extends State<MyTabBar<T>> {
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
//       labelPadding: const EdgeInsets.all(8),
//       labelColor: Colors.amber,
//       labelStyle: const TextStyle(fontSize: 10),
//       unselectedLabelColor: Theme.of(context).colorScheme.surface,
//       unselectedLabelStyle: const TextStyle(fontSize: 8),
//       indicatorColor: Colors.amber,
//       dividerColor: Theme.of(context).colorScheme.surface,
//       controller: widget.tabController,
//       tabs: List.generate(
//         widget.enumValues.length,
//         (index) {
//           final T enumValue = widget.enumValues[index];
//           return Center(
//             child: Column(
//               children: [
//                 Icon(
//                   widget.iconData[index],
//                 ),
//                 Text(
//                   widget.localizedLabel(enumValue, l10n),
//                   style: const TextStyle(fontSize: 10),
//                 ),
//               ],
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
