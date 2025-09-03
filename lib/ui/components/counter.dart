import 'package:flutter/material.dart';

class Counter extends StatefulWidget {
  final int initialValue;
  final ValueChanged<int>? onChanged;

  const Counter({
    super.key,
    this.initialValue = 1,
    this.onChanged,
  });

  @override
  CounterState createState() => CounterState();
}

class CounterState extends State<Counter> {
  late int _counter;

  @override
  void initState() {
    super.initState();
    _counter = widget.initialValue;
  }

  void _increment() {
    setState(() {
      _counter++;
      widget.onChanged?.call(_counter);
    });
  }

  void _decrement() {
    setState(() {
      if (_counter > 1) {
        _counter--;
        widget.onChanged?.call(_counter);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 8.0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildButton(
            icon: Icons.remove,
            onPressed: _decrement,
            isEnabled: _counter > 1,
          ),
          const SizedBox(width: 16.0),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
          ),
          const SizedBox(width: 16.0),
          _buildButton(
            icon: Icons.add,
            onPressed: _increment,
            isEnabled: true,
          ),
        ],
      ),
    );
  }

  Widget _buildButton({
    required IconData icon,
    required VoidCallback onPressed,
    required bool isEnabled,
  }) {
    return Material(
      color: isEnabled
          ? Theme.of(context).colorScheme.primary
          : Theme.of(context).colorScheme.onSurface.withOpacity(0.3),
      borderRadius: BorderRadius.circular(8.0),
      child: InkWell(
        borderRadius: BorderRadius.circular(8.0),
        onTap: isEnabled ? onPressed : null,
        child: Container(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: Theme.of(context).colorScheme.onPrimary,
            size: 24.0,
          ),
        ),
      ),
    );
  }
}
