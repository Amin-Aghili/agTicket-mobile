// import 'package:ag_ticket/models/event_model.dart';
// import 'package:ag_ticket/providers/event_provider.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:intl/intl.dart';

// class EditEvent extends ConsumerStatefulWidget {
//   final EventModel event;
//   const EditEvent({super.key, required this.event});

//   @override
//   ConsumerState<EditEvent> createState() => _EditEventState();
// }

// class _EditEventState extends ConsumerState<EditEvent> {
//   final _formKey = GlobalKey<FormState>();
//   late final TextEditingController _nameController;
//   late final TextEditingController _dateController;
//   late final TextEditingController _timeController;
//   late final TextEditingController _locationController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _totalTicketsController;
//   late final TextEditingController _priceController;
//   late final TextEditingController _imageController;

//   DateTime? _selectedDate;
//   TimeOfDay? _selectedTime;
//   bool _hasChanged = false;

//   late EventModel _initialEvent;

//   @override
//   void initState() {
//     super.initState();
//     _initialEvent = widget.event;

//     _nameController = TextEditingController(text: _initialEvent.eventName);
//     _dateController = TextEditingController(text: _initialEvent.startTime);
//     _timeController = TextEditingController(text: _initialEvent.endTime);
//     _locationController = TextEditingController(text: _initialEvent.location);
//     _descriptionController =
//         TextEditingController(text: "description not available");
//     _totalTicketsController =
//         TextEditingController(text: _initialEvent.capacity.toString());
//     _priceController =
//         TextEditingController(text: _initialEvent.price.toString());
//     _imageController = TextEditingController(text: "no image available");

//     // _selectedDate = DateTime.parse(_initialValues['date']);
//     // _selectedTime = _parseTime(_initialValues['time']);

//     _setupListeners();
//   }

//   TimeOfDay _parseTime(String time) {
//     final parts = time.split(':');
//     final hour = int.tryParse(parts[0]) ?? 0;
//     final minute = int.tryParse(parts[1]) ?? 0;
//     return TimeOfDay(hour: hour, minute: minute);
//   }

//   void _setupListeners() {
//     for (var controller in [
//       _nameController,
//       _dateController,
//       _timeController,
//       _locationController,
//       _descriptionController,
//       _totalTicketsController,
//       _priceController,
//       _imageController,
//     ]) {
//       controller.addListener(_checkForChanges);
//     }
//   }

//   void _checkForChanges() {
//     _hasChanged = _nameController.text != _initialEvent.eventName ||
//         _dateController.text != _initialEvent.startTime ||
//         _timeController.text != _initialEvent.endTime ||
//         _locationController.text != _initialEvent.location ||
//         _descriptionController.text != "no description available" ||
//         _totalTicketsController.text != _initialEvent.capacity.toString() ||
//         _priceController.text != _initialEvent.price.toString() ||
//         _imageController.text != ("no image available");

//     setState(() {});
//   }

//   @override
//   void dispose() {
//     _nameController.dispose();
//     _dateController.dispose();
//     _timeController.dispose();
//     _locationController.dispose();
//     _descriptionController.dispose();
//     _totalTicketsController.dispose();
//     _priceController.dispose();
//     _imageController.dispose();
//     super.dispose();
//   }

//   Future<void> _selectDate(BuildContext context) async {
//     final DateTime? picked = await showDatePicker(
//       context: context,
//       initialDate: _selectedDate ?? DateTime.now(),
//       firstDate: DateTime.now(),
//       lastDate: DateTime(2030),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedDate = picked;
//         _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
//       });
//     }
//   }

//   Future<void> _selectTime(BuildContext context) async {
//     final TimeOfDay? picked = await showTimePicker(
//       context: context,
//       initialTime: _selectedTime ?? TimeOfDay.now(),
//     );
//     if (picked != null) {
//       setState(() {
//         _selectedTime = picked;
//         _timeController.text = picked.format(context);
//       });
//     }
//   }

//   void _saveChanges() {
//     if (_formKey.currentState!.validate()) {
//       final updatedEvent = _initialEvent.copyWith(
//         eventName: _nameController.text,
//         startDate: _selectedDate,
//         startTime: _timeController.text,
//         location: _locationController.text,
//         // description: '_descriptionController.text',
//         capacity: int.tryParse(_totalTicketsController.text),
//         price: int.tryParse(_priceController.text),
//         // image: _imageController.text,
//       );

//       ref.read(eventProvider.notifier).updateEvent(updatedEvent);
//       Navigator.pop(context);
//     }
//   }

//   void _confirmDelete() {
//     showDialog(
//       context: context,
//       builder: (_) => AlertDialog(
//         title: Text('Delete Event'),
//         content: Text('Are you sure you want to delete this event?'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: Text('Cancel'),
//           ),
//           ElevatedButton(
//             onPressed: () {
//               ref.read(eventProvider.notifier).deleteEvent(_initialEvent.id);
//               Navigator.pop(context); // Close dialog
//               Navigator.pop(context); // Close bottom sheet
//             },
//             child: Text('Delete'),
//           ),
//         ],
//       ),
//     );
//   }

//   void _undoChanges() {
//     _nameController.text = _initialEvent.eventName;
//     _dateController.text =
//         _initialEvent.startDate?.toIso8601String().split('T')[0] ?? '';
//     _timeController.text = _initialEvent.startTime ?? '';
//     _locationController.text = _initialEvent.location ?? '';
//     // _descriptionController.text = _initialEvent.description ?? '';
//     _totalTicketsController.text = _initialEvent.capacity.toString();
//     _priceController.text = _initialEvent.price.toString();
//     // _imageController.text = "_initialEvent.image" ?? '';
//     _selectedDate = _initialEvent.startDate;
//     // _selectedTime = _parseTime(_initialEvent.startTime);

//     setState(() {
//       _hasChanged = false;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.only(
//         bottom: MediaQuery.of(context).viewInsets.bottom,
//         left: 16,
//         right: 16,
//         top: 16,
//       ),
//       child: Form(
//         key: _formKey,
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Text(
//                 'Edit Event',
//                 style: Theme.of(context).textTheme.headlineSmall,
//               ),
//               const SizedBox(height: 16),
//               _buildTextField(_nameController, 'Event Name'),
//               _buildDateField(),
//               _buildTimeField(),
//               _buildTextField(_locationController, 'Location'),
//               _buildTextField(_descriptionController, 'Description',
//                   maxLines: 3),
//               _buildTextField(_totalTicketsController, 'Total Tickets',
//                   keyboardType: TextInputType.number),
//               _buildTextField(_priceController, 'Price',
//                   keyboardType: TextInputType.numberWithOptions(decimal: true)),
//               _buildTextField(_imageController, 'Image URL (optional)'),
//               const SizedBox(height: 16),
//               Row(
//                 children: [
//                   ElevatedButton.icon(
//                     icon: Icon(Icons.delete),
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: _confirmDelete,
//                     label: Text('Delete'),
//                   ),
//                   const Spacer(),
//                   if (_hasChanged) ...[
//                     TextButton(
//                       onPressed: _undoChanges,
//                       child: Text('Undo'),
//                     ),
//                     ElevatedButton(
//                       onPressed: _saveChanges,
//                       child: Text('Save Changes'),
//                     ),
//                   ] else
//                     OutlinedButton(
//                       onPressed: () => Navigator.pop(context),
//                       child: Text('Cancel'),
//                     ),
//                 ],
//               ),
//               const SizedBox(height: 16),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildTextField(TextEditingController controller, String label,
//       {int maxLines = 1, TextInputType keyboardType = TextInputType.text}) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         controller: controller,
//         decoration:
//             InputDecoration(labelText: label, border: OutlineInputBorder()),
//         maxLines: maxLines,
//         keyboardType: keyboardType,
//         validator: (value) =>
//             value!.isEmpty ? 'Please enter $label'.toLowerCase() : null,
//       ),
//     );
//   }

//   Widget _buildDateField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         controller: _dateController,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: 'Date',
//           border: OutlineInputBorder(),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.calendar_today),
//             onPressed: () => _selectDate(context),
//           ),
//         ),
//         validator: (value) => value!.isEmpty ? 'Please select a date' : null,
//       ),
//     );
//   }

//   Widget _buildTimeField() {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 8),
//       child: TextFormField(
//         controller: _timeController,
//         readOnly: true,
//         decoration: InputDecoration(
//           labelText: 'Time',
//           border: OutlineInputBorder(),
//           suffixIcon: IconButton(
//             icon: Icon(Icons.access_time),
//             onPressed: () => _selectTime(context),
//           ),
//         ),
//         validator: (value) => value!.isEmpty ? 'Please select a time' : null,
//       ),
//     );
//   }
// }
