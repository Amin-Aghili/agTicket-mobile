// import 'package:flutter/material.dart';
// import 'package:flutter_ticket/ui/components/counter.dart';
// import 'package:flutter_ticket/ui/components/my_button.dart';
// import 'package:flutter_ticket/ui/components/my_text_form_field.dart';
// // import 'package:flutter_ticket/utils/format.dart';

// class EventBottomSheet extends StatefulWidget {
//   const EventBottomSheet({
//     super.key,
//     required this.event,
//   });
//   final Map<String, dynamic> event;

//   @override
//   State<EventBottomSheet> createState() => _EventBottomSheetState();
// }

// class _EventBottomSheetState extends State<EventBottomSheet> {
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController phoneController = TextEditingController();
//   final FocusNode focusNode = FocusNode();
//   final formKey = GlobalKey<FormState>();
//   int ticketCount = 1;

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       FocusScope.of(context).requestFocus(focusNode);
//     });
//   }

//   @override
//   void dispose() {
//     focusNode.dispose();
//     nameController.dispose();
//     emailController.dispose();
//     phoneController.dispose();
//     super.dispose();
//   }

//   void _showConfirmationDialog() {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return AlertDialog(
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12.0),
//           ),
//           title: const Text(
//             'accept ticket',
//             style: TextStyle(fontWeight: FontWeight.bold),
//           ),
//           content: SingleChildScrollView(
//             child: Column(
//               mainAxisSize: MainAxisSize.min,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text('Name: ${nameController.text}'),
//                 const SizedBox(height: 8.0),
//                 Text('Phone Number : ${phoneController.text}'),
//                 const SizedBox(height: 8.0),
//                 Text('Email: ${emailController.text}'),
//                 const SizedBox(height: 8.0),
//                 Text('Count Ticket : $ticketCount'),
//                 const SizedBox(height: 8.0),
//                 Text('Name Event: ${widget.event['name'] ?? ' No Name'}'),
//                 const SizedBox(height: 8.0),
//                 Text('Time: ${widget.event['time'] ?? ' No Time'}'),
//                 const SizedBox(height: 8.0),
//                 Text('Date: ${widget.event['date'] ?? ' No Date'}'),
//                 const SizedBox(height: 8.0),
//                 Text(
//                   'Price: ${((widget.event['price'] ?? 0) * ticketCount).toStringAsFixed(2)} TL',
//                   style: const TextStyle(
//                     fontSize: 16.0,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: const Text(
//                 'Cancel',
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//                 Navigator.of(context).pop();
//               },
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: Theme.of(context).colorScheme.primary,
//                 foregroundColor: Theme.of(context).colorScheme.onPrimary,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8.0),
//                 ),
//               ),
//               child: const Text('Confirm Purchase'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       constraints: BoxConstraints(
//         maxHeight: MediaQuery.of(context).size.height * 0.8,
//       ),
//       child: Padding(
//         padding:
//             const EdgeInsets.only(bottom: 20.0, top: 3, left: 10, right: 10),
//         child: Form(
//           key: formKey,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 children: [
//                   Text(widget.event['time'] != null
//                       ? ' ${widget.event['time']}'
//                       : ''),
//                   Text(
//                     widget.event['name'] ?? 'No Name',
//                     style: const TextStyle(
//                       fontSize: 20.0,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(widget.event['date'] != null
//                       ? '${widget.event['date']}'
//                       : ''),
//                 ],
//               ),
//               const Divider(),
//               Flexible(
//                 fit: FlexFit.loose,
//                 child: SingleChildScrollView(
//                   child: Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Image.network(
//                         widget.event['image'] ?? '',
//                         errorBuilder: (context, error, stackTrace) =>
//                             const Icon(Icons.error),
//                       ),
//                       const SizedBox(height: 16.0),
//                       MyTextFormField(
//                         controller: nameController,
//                         hintText: 'Full Name',
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your name';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       MyTextFormField(
//                         controller: phoneController,
//                         hintText: 'Phone Number',
//                         type: TextInputType.phone,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your phone number';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       MyTextFormField(
//                         controller: emailController,
//                         hintText: 'Email Address',
//                         type: TextInputType.emailAddress,
//                         validator: (value) {
//                           if (value == null || value.isEmpty) {
//                             return 'Please enter your email';
//                           }
//                           if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
//                               .hasMatch(value)) {
//                             return 'Please enter a valid email';
//                           }
//                           return null;
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       Text(
//                         'Price: ${((widget.event['price']) * ticketCount).toStringAsFixed(2)} TL',
//                         style: const TextStyle(
//                           fontSize: 16.0,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                       const SizedBox(height: 16.0),
//                       Counter(
//                         onChanged: (value) {
//                           setState(() {
//                             ticketCount = value;
//                           });
//                         },
//                       ),
//                       const SizedBox(height: 16.0),
//                       MyButton(
//                         text: 'Buy Ticket',
//                         onTap: () {
//                           if (formKey.currentState?.validate() ?? false) {
//                             _showConfirmationDialog();
//                           }
//                         },
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
