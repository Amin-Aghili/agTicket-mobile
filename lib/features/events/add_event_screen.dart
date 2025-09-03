import 'package:ag_ticket/models/event_model.dart';
import 'package:ag_ticket/services/event_service.dart';
import 'package:flutter/material.dart';

class AddEventScreen extends StatefulWidget {
  const AddEventScreen({super.key});

  @override
  State<AddEventScreen> createState() => _AddEventScreenState();
}

class _AddEventScreenState extends State<AddEventScreen> {
  final _formKey = GlobalKey<FormState>();
  final _eventNameController = TextEditingController();
  final _locationController = TextEditingController();
  final _capacityController = TextEditingController();
  final _priceController = TextEditingController();
  final _minAgeController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;
  bool _isEveryDay = false;

  final EventService _eventService = EventService();

  Future<void> _selectDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2024),
      lastDate: DateTime(2030),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  Future<void> _selectTime(BuildContext context, bool isStart) async {
    final picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (picked != null) {
      setState(() {
        if (isStart) {
          _startTime = picked;
        } else {
          _endTime = picked;
        }
      });
    }
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final event = EventModel(
        id: 0,
        companyId: 1,
        creatorUserId: 1,
        eventName: _eventNameController.text,
        eventTypeId: null,
        location: _locationController.text,
        capacity: int.tryParse(_capacityController.text),
        price: int.tryParse(_priceController.text),
        priceCurrencyId: 1,
        minAge: int.tryParse(_minAgeController.text),
        startDate: _startDate,
        endDate: _endDate,
        startTime: _startTime,
        endTime: _endTime,
        isEveryDay: _isEveryDay,
        createdAt: DateTime.now(),
      );

      try {
        await _eventService.createEvent(event);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Event created successfully")),
          );
          Navigator.pop(context);
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Error: $e")),
          );
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Add Event")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _eventNameController,
                decoration: const InputDecoration(labelText: "Event Name"),
                validator: (v) =>
                    v == null || v.isEmpty ? "Enter event name" : null,
              ),
              TextFormField(
                controller: _locationController,
                decoration: const InputDecoration(labelText: "Location"),
              ),
              TextFormField(
                controller: _capacityController,
                decoration: const InputDecoration(labelText: "Capacity"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
              TextFormField(
                controller: _minAgeController,
                decoration: const InputDecoration(labelText: "Min Age"),
                keyboardType: TextInputType.number,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context, true),
                      child: Text(
                          "Start Date: ${_startDate?.toString().split(' ')[0] ?? 'Pick'}"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectDate(context, false),
                      child: Text(
                          "End Date: ${_endDate?.toString().split(' ')[0] ?? 'Pick'}"),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context, true),
                      child: Text(
                          "Start Time: ${_startTime?.format(context) ?? 'Pick'}"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => _selectTime(context, false),
                      child: Text(
                          "End Time: ${_endTime?.format(context) ?? 'Pick'}"),
                    ),
                  ),
                ],
              ),
              SwitchListTile(
                title: const Text("Is Every Day?"),
                value: _isEveryDay,
                onChanged: (val) {
                  setState(() {
                    _isEveryDay = val;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submit,
                child: const Text("Save Event"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
