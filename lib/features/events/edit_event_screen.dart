import 'package:ag_ticket/models/event_model.dart';
import 'package:ag_ticket/providers/event_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EditEventStepper extends ConsumerStatefulWidget {
  final EventModel event;

  const EditEventStepper({super.key, required this.event});

  @override
  ConsumerState<EditEventStepper> createState() => _EditEventStepperState();
}

class _EditEventStepperState extends ConsumerState<EditEventStepper> {
  int _currentStep = 0;
  bool _isChanged = false;

  late TextEditingController _nameController;
  late TextEditingController _locationController;
  late TextEditingController _capacityController;
  late TextEditingController _priceController;
  DateTime? _startDate;
  DateTime? _endDate;

  late EventModel _originalEvent;

  @override
  void initState() {
    super.initState();
    _originalEvent = widget.event;
    _initControllers();
  }

  void _initControllers() {
    _nameController = TextEditingController(text: _originalEvent.eventName);
    _locationController =
        TextEditingController(text: _originalEvent.location ?? "");
    _capacityController =
        TextEditingController(text: _originalEvent.capacity?.toString() ?? "");
    _priceController =
        TextEditingController(text: _originalEvent.price?.toString() ?? "");
    _startDate = _originalEvent.startDate;
    _endDate = _originalEvent.endDate;

    for (var controller in [
      _nameController,
      _locationController,
      _capacityController,
      _priceController,
    ]) {
      controller.addListener(_checkChanges);
    }
  }

  void _checkChanges() {
    final changed = _nameController.text != _originalEvent.eventName ||
        _locationController.text != (_originalEvent.location ?? "") ||
        _capacityController.text !=
            (_originalEvent.capacity?.toString() ?? "") ||
        _priceController.text != (_originalEvent.price?.toString() ?? "") ||
        _startDate != _originalEvent.startDate ||
        _endDate != _originalEvent.endDate;

    if (changed != _isChanged) {
      setState(() {
        _isChanged = changed;
      });
    }
  }

  void _undoChanges() {
    setState(() {
      _nameController.text = _originalEvent.eventName;
      _locationController.text = _originalEvent.location ?? "";
      _capacityController.text = _originalEvent.capacity?.toString() ?? "";
      _priceController.text = _originalEvent.price?.toString() ?? "";
      _startDate = _originalEvent.startDate;
      _endDate = _originalEvent.endDate;
      _isChanged = false;
    });
  }

  Future<void> _updateEvent() async {
    final notifier = ref.read(eventProvider.notifier);

    final updatedEvent = _originalEvent.copyWith(
      eventName: _nameController.text,
      location: _locationController.text,
      capacity: int.tryParse(_capacityController.text),
      price: int.tryParse(_priceController.text),
      startDate: _startDate,
      endDate: _endDate,
    );

    await notifier.updateEvent(updatedEvent);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Saved changes")),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _deleteEvent() async {
    final notifier = ref.read(eventProvider.notifier);
    await notifier.deleteEvent(_originalEvent.id);

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Event deleted")),
      );
      Navigator.pop(context);
    }
  }

  Future<void> _pickDate(BuildContext context, bool isStart) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: isStart
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
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
      _checkChanges();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Event"),
        actions: [
          if (_isChanged) ...[
            IconButton(
              icon: const Icon(Icons.undo),
              tooltip: "Undo",
              onPressed: _undoChanges,
            ),
            IconButton(
              icon: const Icon(Icons.save),
              tooltip: "Save Changes",
              onPressed: _updateEvent,
            ),
          ],
          IconButton(
            icon: const Icon(Icons.delete),
            tooltip: "Delete",
            onPressed: () async {
              final confirm = await showDialog<bool>(
                context: context,
                builder: (_) => AlertDialog(
                  title: const Text("Delete Event"),
                  content:
                      const Text("Are you sure you want to delete this event?"),
                  actions: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, false),
                        child: const Text("Cancel")),
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text("Delete")),
                  ],
                ),
              );
              if (confirm == true) {
                _deleteEvent();
              }
            },
          )
        ],
      ),
      body: Stepper(
        type: StepperType.horizontal,
        currentStep: _currentStep,
        onStepContinue: () {
          if (_currentStep < 2) {
            setState(() => _currentStep += 1);
          }
        },
        onStepCancel: () {
          if (_currentStep > 0) {
            setState(() => _currentStep -= 1);
          }
        },
        steps: [
          Step(
            title: const Text("Basic Info"),
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
            title: const Text("Capacity/Quantity"),
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
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _startDate == null
                            ? "Start date not selected"
                            : "Start: ${_startDate!.toLocal().toString().split(' ')[0]}",
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, true),
                      child: const Text("Select Start Date"),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        _endDate == null
                            ? "End date not selected"
                            : "End: ${_endDate!.toLocal().toString().split(' ')[0]}",
                      ),
                    ),
                    TextButton(
                      onPressed: () => _pickDate(context, false),
                      child: const Text("Select End Date"),
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
