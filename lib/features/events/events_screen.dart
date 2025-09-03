// import 'package:ag_ticket/models/company_model.dart';
// import 'package:ag_ticket/services/company_service.dart';
// import 'package:flutter/material.dart';

// class EventsScreen extends StatefulWidget {
//   const EventsScreen({super.key});

//   @override
//   State<EventsScreen> createState() => _EventsScreenState();
// }

// class _EventsScreenState extends State<EventsScreen> {
//   final companyService = CompanyService();
//   final _nameController = TextEditingController();
//   int? _editingCompanyId;

//   void _showCompanyDialog({CompanyModel? company}) {
//     if (company != null) {
//       _nameController.text = company.name;
//       _editingCompanyId = company.id;
//     } else {
//       _nameController.clear();
//       _editingCompanyId = null;
//     }

//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text(company == null ? 'Add Company' : 'Edit Company'),
//         content: TextField(
//           controller: _nameController,
//           decoration: const InputDecoration(labelText: 'Company Name'),
//         ),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () async {
//               if (_nameController.text.isEmpty) return;
//               try {
//                 if (_editingCompanyId == null) {
//                   // Add new company
//                   await companyService.insertCompany(
//                     CompanyModel(
//                       id: 0, // Supabase will generate ID
//                       name: _nameController.text,
//                       createdAt: DateTime.now(),
//                     ),
//                   );
//                 } else {
//                   // Update existing company
//                   await companyService.updateCompany(
//                     CompanyModel(
//                       id: _editingCompanyId!,
//                       name: _nameController.text,
//                       createdAt: company!.createdAt,
//                     ),
//                   );
//                 }
//                 Navigator.pop(context);
//                 setState(() {}); // Refresh the list
//               } catch (e) {
//                 ScaffoldMessenger.of(context).showSnackBar(
//                   SnackBar(content: Text('Error: $e')),
//                 );
//               }
//             },
//             child: const Text('Save'),
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Companies'),
//         actions: [
//           IconButton(
//             icon: const Icon(Icons.add),
//             onPressed: () => _showCompanyDialog(),
//           ),
//         ],
//       ),
//       body: FutureBuilder<List<CompanyModel>>(
//         future: companyService.getAllCompanies(),
//         builder: (context, snapshot) {
//           if (snapshot.connectionState == ConnectionState.waiting) {
//             return const Center(child: CircularProgressIndicator());
//           }
//           if (snapshot.hasError) {
//             return Center(child: Text('Error: ${snapshot.error}'));
//           }
//           final companies = snapshot.data ?? [];
//           if (companies.isEmpty) {
//             return const Center(
//                 child: Text(
//                     'No companies found. Check RLS policies or table data.'));
//           }
//           return ListView.builder(
//             itemCount: companies.length,
//             itemBuilder: (context, index) {
//               final company = companies[index];
//               return ListTile(
//                 title: Text(company.name),
//                 subtitle: Text(
//                     'ID: ${company.id} | Created: ${company.createdAt.toLocal()}'),
//                 trailing: Row(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     IconButton(
//                       icon: const Icon(Icons.edit),
//                       onPressed: () => _showCompanyDialog(company: company),
//                     ),
//                     IconButton(
//                       icon: const Icon(Icons.delete),
//                       onPressed: () async {
//                         try {
//                           await companyService.deleteCompany(company.id);
//                           setState(() {}); // Refresh the list
//                         } catch (e) {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(content: Text('Error: $e')),
//                           );
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:ag_ticket/features/events/add_event_steper.dart';
import 'package:ag_ticket/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final eventState = ref.watch(eventProvider);

    return Scaffold(
      appBar: AppBar(title: const Text("Events")),
      body: eventState.events.isEmpty
          ? const Center(child: Text("No events registered"))
          : ListView.builder(
              itemCount: eventState.events.length,
              itemBuilder: (context, index) {
                final event = eventState.events[index];
                return ListTile(
                  title: Text(event.eventName),
                  subtitle: Text(event.location ?? ""),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEventStepper()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
