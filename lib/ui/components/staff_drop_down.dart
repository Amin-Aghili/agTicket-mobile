import 'package:flutter/material.dart';

enum StaffRole {
  seller,
  cashier,
  manager,
  ticketChecker,
}

class Staff {
  final String name;
  final String phoneNumber;
  final StaffRole role;

  Staff({
    required this.name,
    required this.phoneNumber,
    required this.role,
  });
}

class StaffDropdown extends StatefulWidget {
  final List<Staff> staffList;
  final Function(Staff?) onSelect;
  final String placeholder;
  final EdgeInsets? padding;

  const StaffDropdown({
    super.key,
    required this.staffList,
    required this.onSelect,
    this.placeholder = 'انتخاب کارمند',
    this.padding,
  });

  @override
  State<StaffDropdown> createState() => _StaffDropdownState();
}

class _StaffDropdownState extends State<StaffDropdown> {
  Staff? _selectedStaff;
  String _searchQuery = '';
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  bool _isDropdownOpen = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && _selectedStaff != null) {
        setState(() {
          _controller.clear();
          _searchQuery = '';
          _selectedStaff = null;
          widget.onSelect(null);
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  List<Staff> get _filteredStaffList {
    if (_searchQuery.isEmpty) {
      return widget.staffList;
    }
    return widget.staffList
        .where((staff) =>
            staff.name.toLowerCase().contains(_searchQuery.toLowerCase()))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 0),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    focusNode: _focusNode,
                    decoration: InputDecoration(
                      hintText:
                          _selectedStaff == null ? widget.placeholder : '',
                      border: InputBorder.none,
                      hintStyle: const TextStyle(color: Colors.grey),
                      contentPadding: const EdgeInsets.all(0),
                    ),
                    onTap: () {
                      setState(() {
                        _isDropdownOpen = true;
                      });
                    },
                    onChanged: (value) {
                      setState(() {
                        _searchQuery = value;
                        _isDropdownOpen = true;
                      });
                    },
                  ),
                ),
                Icon(
                  _isDropdownOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
              ],
            ),
          ),
          if (_isDropdownOpen)
            Container(
              constraints: const BoxConstraints(maxHeight: 200),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              margin: const EdgeInsets.only(top: 4),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredStaffList.length,
                itemBuilder: (context, index) {
                  final staff = _filteredStaffList[index];
                  return ListTile(
                    title: Text(staff.name),
                    subtitle: Text(staff.phoneNumber),
                    onTap: () {
                      setState(() {
                        _selectedStaff = staff;
                        _controller.text = staff.name;
                        _searchQuery = '';
                        _isDropdownOpen = false;
                        _focusNode.unfocus();
                      });
                      widget.onSelect(staff);
                    },
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
