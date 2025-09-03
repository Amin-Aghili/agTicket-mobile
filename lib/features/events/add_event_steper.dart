import 'package:ag_ticket/models/event_model.dart';
import 'package:ag_ticket/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddEventStepper extends ConsumerStatefulWidget {
  const AddEventStepper({super.key});

  @override
  ConsumerState<AddEventStepper> createState() => _AddEventStepperState();
}

class _AddEventStepperState extends ConsumerState<AddEventStepper> {
  int _currentStep = 0;

  final _nameController = TextEditingController();
  final _locationController = TextEditingController();
  final _capacityController = TextEditingController();
  final _priceController = TextEditingController();

  DateTime? _startDate;
  DateTime? _endDate;
  TimeOfDay? _startTime;
  TimeOfDay? _endTime;

  Future<void> _pickDate(BuildContext context, bool isStart) async {
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

  Future<void> _pickTime(BuildContext context, bool isStart) async {
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

  Future<void> _saveEvent() async {
    final notifier = ref.read(eventProvider.notifier);

    final newEvent = EventModel(
      id: DateTime.now().millisecondsSinceEpoch,
      companyId: 1,
      creatorUserId: 1,
      eventName: _nameController.text,
      eventTypeId: 1,
      location: _locationController.text,
      capacity: int.tryParse(_capacityController.text),
      price: int.tryParse(_priceController.text),
      priceCurrencyId: 1,
      minAge: 18,
      startDate: _startDate,
      endDate: _endDate,
      startTime: _startTime,
      endTime: _endTime,
      isEveryDay: false,
      createdAt: DateTime.now(),
      status: 1,
    );

    await notifier.addEvent(newEvent);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("added event successfully")),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("add event")),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          } else {
            _saveEvent();
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        steps: [
          Step(
            title: const Text("Basic"),
            content: Column(
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: "Event Name"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _locationController,
                  decoration: const InputDecoration(labelText: "Location"),
                ),
              ],
            ),
            isActive: _currentStep >= 0,
          ),
          Step(
            title: const Text("Capacity"),
            content: Column(
              children: [
                TextField(
                  controller: _capacityController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Capacity"),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: _priceController,
                  keyboardType: TextInputType.number,
                  decoration: const InputDecoration(labelText: "Price"),
                ),
              ],
            ),
            isActive: _currentStep >= 1,
          ),
          Step(
            title: const Text("Date"),
            content: Column(
              children: [
                // Start Date
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _startDate == null
                            ? "start date not selected"
                            : "start date: ${_startDate!.toLocal().toString().split(' ')[0]}",
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, true),
                      child: const Text("select start date"),
                    ),
                  ],
                ),
                // End Date
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _endDate == null
                            ? "end date not selected"
                            : "end date: ${_endDate!.toLocal().toString().split(' ')[0]}",
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, false),
                      child: const Text("select end date"),
                    ),
                  ],
                ),
                const Divider(),
                // Start Time
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _startTime == null
                            ? "start time not selected"
                            : "start time: ${_startTime!.format(context)}",
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickTime(context, true),
                      child: const Text("select start time"),
                    ),
                  ],
                ),
                // End Time
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _endTime == null
                            ? "end time not selected"
                            : "end time: ${_endTime!.format(context)}",
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickTime(context, false),
                      child: const Text("select end time"),
                    ),
                  ],
                ),
              ],
            ),
            isActive: _currentStep >= 2,
          ),
        ],
      ),
    );
  }
}
