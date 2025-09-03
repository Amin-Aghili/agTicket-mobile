import 'package:ag_ticket/models/event_model.dart';
import 'package:ag_ticket/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEvent extends ConsumerStatefulWidget {
  const AddEvent({super.key});

  @override
  ConsumerState<AddEvent> createState() => _AddEventState();
}

class _AddEventState extends ConsumerState<AddEvent> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _dateController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _totalTicketsController = TextEditingController();
  final _priceController = TextEditingController();
  final _imageController = TextEditingController();

  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;

  @override
  void initState() {
    super.initState();
    _nameController.text = 'Sunset Beach Party';
    _locationController.text = 'Istanbul Beach Club';
    _descriptionController.text = 'A fun beach party with DJ and drinks.';
    _totalTicketsController.text = '100';
    _priceController.text = '49.99';
    _imageController.text =
        'https://media.istockphoto.com/id/475069301/tr/foto%C4%9Fraf/sailing-crew-on-sailboat-during-regatta.webp?s=1024x1024&w=is&k=20&c=NFhjRYUoU14V520RSTxQPTU2dRUYPr0e331xVokad2Q=';

    final now = DateTime.now();
    _selectedDate = now;
    _dateController.text = DateFormat('yyyy-MM-dd').format(now);

    _selectedTime = TimeOfDay.now();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _timeController.text = _selectedTime!.format(context);
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dateController.dispose();
    _timeController.dispose();
    _locationController.dispose();
    _descriptionController.dispose();
    _totalTicketsController.dispose();
    _priceController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
        context: context, initialTime: _selectedTime ?? TimeOfDay.now());
    if (picked != null) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = picked.format(context);
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      final eventNotifier = ref.read(eventProvider.notifier);

      final newEvent = EventModel(
        id: DateTime.now().millisecondsSinceEpoch, // temporary unique ID
        eventName: _nameController.text,
        startDate: DateTime.now(),
        endDate: DateTime.now(),
        location: _locationController.text,
        capacity: int.parse(_totalTicketsController.text),
        status: 0,
        price: 300,
        companyId: 0,
        creatorUserId: 0,
        priceCurrencyId: 0,
        createdAt: DateTime.now(),
      );

      eventNotifier.addEvent(newEvent); // Add to EventProvider
      Navigator.pop(context); // Close the bottom sheet
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16,
        right: 16,
        top: 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Add New Event',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                    labelText: 'Event Name', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter event name' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _dateController,
                decoration: InputDecoration(
                  labelText: 'Date (YYYY-MM-DD)',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.calendar_today),
                      onPressed: () => _selectDate(context)),
                ),
                readOnly: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please select a date' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _timeController,
                decoration: InputDecoration(
                  labelText: 'Time',
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                      icon: const Icon(Icons.access_time),
                      onPressed: () => _selectTime(context)),
                ),
                readOnly: true,
                validator: (value) =>
                    value!.isEmpty ? 'Please select a time' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(
                    labelText: 'Location', border: OutlineInputBorder()),
                validator: (value) =>
                    value!.isEmpty ? 'Please enter location' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(
                    labelText: 'Description', border: OutlineInputBorder()),
                maxLines: 3,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter description' : null,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _totalTicketsController,
                decoration: const InputDecoration(
                    labelText: 'Total Tickets', border: OutlineInputBorder()),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter total tickets';
                  if (int.tryParse(value) == null || int.parse(value) <= 0)
                    return 'Please enter a valid number';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(
                    labelText: 'Price', border: OutlineInputBorder()),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value!.isEmpty) return 'Please enter price';
                  if (double.tryParse(value) == null || double.parse(value) < 0)
                    return 'Please enter a valid price';
                  return null;
                },
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _imageController,
                decoration: const InputDecoration(
                    labelText: 'Image URL (optional)',
                    border: OutlineInputBorder()),
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                  onPressed: _submitForm, child: const Text('Add Event')),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
