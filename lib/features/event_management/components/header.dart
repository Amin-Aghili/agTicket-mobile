import 'package:ag_ticket/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Header extends ConsumerWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventNotifier = ref.read(eventProvider.notifier);
    final searchController = eventNotifier.searchController;
    final focusNode = eventNotifier.focusNode;

    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: TextField(
              controller: searchController,
              focusNode: focusNode,
              onChanged: (value) {
                // هر تایپی که کاربر انجام می‌دهد، state EventProvider بروزرسانی شود
                eventNotifier.setSearchQuery(value);
              },
              decoration: InputDecoration(
                hintText: 'Search events',
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.1),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.5),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          eventNotifier.clearSearch();
                        },
                      )
                    : const Icon(Icons.search),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
