import 'package:flutter/material.dart';
import 'package:ag_ticket/ui/components/my_text_form_field.dart';

typedef ItemLabelBuilder<T> = String Function(T item);

class MyDropdown<T> extends StatefulWidget {
  final List<T> items;
  final ItemLabelBuilder<T> itemLabel;
  final ItemLabelBuilder<T>? selectedItemLabel;
  final void Function(T?) onSelect;
  final String placeholder;
  final bool searchable;
  final String? Function(T?)? validator;
  final T? initialValue;
  final bool icon;
  final int visibleItemCount;

  const MyDropdown({
    super.key,
    required this.items,
    required this.itemLabel,
    required this.onSelect,
    this.selectedItemLabel,
    this.placeholder = 'Select an item',
    this.searchable = true,
    this.validator,
    this.initialValue,
    this.icon = true,
    this.visibleItemCount = 4,
  });

  @override
  State<MyDropdown<T>> createState() => _MyDropdownState<T>();
}

class _MyDropdownState<T> extends State<MyDropdown<T>> {
  T? _selectedItem;
  String _searchQuery = '';
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final LayerLink _layerLink = LayerLink();
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    _selectedItem = widget.initialValue;
    if (_selectedItem != null) {
      _controller.text = _displaySelected(_selectedItem as T);
    }
    _focusNode.addListener(() {
      if (!_focusNode.hasFocus) {
        _removeOverlay();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    _removeOverlay();
    super.dispose();
  }

  String _displaySelected(T item) {
    return widget.selectedItemLabel != null
        ? widget.selectedItemLabel!(item)
        : widget.itemLabel(item);
  }

  List<T> get _filteredItems {
    if (_searchQuery.isEmpty) return widget.items;
    return widget.items
        .where((item) => widget
            .itemLabel(item)
            .toLowerCase()
            .contains(_searchQuery.toLowerCase()))
        .toList();
  }

  double _calculateTextWidth(String text) {
    final textPainter = TextPainter(
      text: TextSpan(text: text, style: const TextStyle(fontSize: 16)),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout();
    return textPainter.size.width + 40;
  }

  void _showOverlay() {
    _removeOverlay();
    _overlayEntry = _createOverlayEntry();
    Overlay.of(context).insert(_overlayEntry!);
  }

  void _removeOverlay() {
    _overlayEntry?.remove();
    _overlayEntry = null;
  }

  OverlayEntry _createOverlayEntry() {
    final itemsWidths = [
      _calculateTextWidth(widget.placeholder),
      ..._filteredItems
          .map((item) => _calculateTextWidth(widget.itemLabel(item)))
    ];
    final double maxWidth = itemsWidths.reduce((a, b) => a > b ? a : b);

    const double itemHeight = kMinInteractiveDimension;
    final int visibleCount =
        widget.visibleItemCount.clamp(1, _filteredItems.length);
    final double maxHeight = itemHeight * visibleCount;

    return OverlayEntry(
      builder: (context) {
        return GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => _removeOverlay(), // کلیک بیرون برای بستن
          child: Stack(
            children: [
              Positioned(
                child: CompositedTransformFollower(
                  link: _layerLink,
                  offset: const Offset(0, 40),
                  showWhenUnlinked: false,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: maxHeight,
                        minWidth: maxWidth,
                        maxWidth: maxWidth,
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.zero,
                        shrinkWrap: true,
                        itemCount: _filteredItems.length,
                        itemBuilder: (context, index) {
                          final item = _filteredItems[index];
                          return SizedBox(
                            height: itemHeight,
                            child: ListTile(
                              title: Text(widget.itemLabel(item)),
                              onTap: () {
                                setState(() {
                                  _selectedItem = item;
                                  _controller.text = _displaySelected(item);
                                  _searchQuery = '';
                                });
                                widget.onSelect(item);
                                _removeOverlay();
                                _focusNode.unfocus();
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final fieldWidth = _calculateTextWidth(
      _selectedItem != null
          ? _displaySelected(_selectedItem as T)
          : widget.placeholder,
    );

    return CompositedTransformTarget(
      link: _layerLink,
      child: SizedBox(
        width: fieldWidth,
        child: MyTextFormField(
          paddingHorizontal: 0,
          controller: _controller,
          focusNode: _focusNode,
          readOnly: widget.searchable,
          hintText: _selectedItem == null ? widget.placeholder : null,
          suffixIcon: widget.icon
              ? (_focusNode.hasFocus && widget.searchable
                  ? const Icon(Icons.clear)
                  : const Icon(Icons.arrow_drop_down))
              : null,
          onTapSuffix: () {
            setState(() {
              _controller.clear();
              _searchQuery = '';
              _selectedItem = null;
            });
            widget.onSelect(null);
          },
          // decoration: InputDecoration(
          //   hintText: _selectedItem == null ? widget.placeholder : null,
          //   border: const OutlineInputBorder(),
          //   suffixIcon: widget.icon
          //       ? (_focusNode.hasFocus && widget.searchable
          //           ? IconButton(
          //               icon: const Icon(Icons.clear),
          //               onPressed: () {
          //                 setState(() {
          //                   _controller.clear();
          //                   _searchQuery = '';
          //                   _selectedItem = null;
          //                 });
          //                 widget.onSelect(null);
          //               },
          //             )
          //           : const Icon(Icons.arrow_drop_down))
          //       : null,
          // ),
          validator: (value) {
            if (widget.validator != null) {
              return widget.validator!(_selectedItem);
            }
            return null;
          },
          onChanged: (value) {
            if (widget.searchable) {
              setState(() => _searchQuery = value);
              _showOverlay();
            }
          },
          onTap: () {
            if (_overlayEntry == null) {
              _showOverlay();
            }
          },
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';

// typedef ItemLabelBuilder<T> = String Function(T item);

// class MyDropdown<T> extends StatefulWidget {
//   final List<T> items;
//   final ItemLabelBuilder<T> itemLabel; // برای نمایش در منو
//   final ItemLabelBuilder<T>? selectedItemLabel; // برای نمایش در فیلد
//   final void Function(T?) onSelect;
//   final String placeholder;
//   final EdgeInsets? padding;
//   final bool searchable;
//   final String? Function(T?)? validator;
//   final T? initialValue;
//   final bool icon;

//   const MyDropdown({
//     super.key,
//     required this.items,
//     required this.itemLabel,
//     required this.onSelect,
//     this.selectedItemLabel,
//     this.placeholder = 'Select an item',
//     this.padding,
//     this.searchable = true,
//     this.validator,
//     this.initialValue,
//     this.icon = true,
//   });

//   @override
//   State<MyDropdown<T>> createState() => _MyDropdownState<T>();
// }

// class _MyDropdownState<T> extends State<MyDropdown<T>> {
//   T? _selectedItem;
//   String _searchQuery = '';
//   final TextEditingController _controller = TextEditingController();
//   final FocusNode _focusNode = FocusNode();
//   final LayerLink _layerLink = LayerLink();
//   OverlayEntry? _overlayEntry;

//   @override
//   void initState() {
//     super.initState();
//     _selectedItem = widget.initialValue;
//     if (_selectedItem != null) {
//       _controller.text = _displaySelected(_selectedItem!);
//     }
//     _focusNode.addListener(() => setState(() {}));
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _focusNode.dispose();
//     _removeOverlay();
//     super.dispose();
//   }

//   String _displaySelected(T item) {
//     return widget.selectedItemLabel != null
//         ? widget.selectedItemLabel!(item)
//         : widget.itemLabel(item);
//   }

//   List<T> get _filteredItems {
//     if (_searchQuery.isEmpty) return widget.items;
//     return widget.items
//         .where((item) => widget
//             .itemLabel(item)
//             .toLowerCase()
//             .contains(_searchQuery.toLowerCase()))
//         .toList();
//   }

//   double _calculateTextWidth(String text) {
//     final textPainter = TextPainter(
//       text: TextSpan(text: text, style: const TextStyle(fontSize: 16)),
//       maxLines: 1,
//       textDirection: TextDirection.ltr,
//     )..layout();
//     return textPainter.size.width + 40; // padding + icon
//   }

//   void _showOverlay() {
//     _overlayEntry = _createOverlayEntry();
//     Overlay.of(context).insert(_overlayEntry!);
//   }

//   void _removeOverlay() {
//     _overlayEntry?.remove();
//     _overlayEntry = null;
//   }

//   OverlayEntry _createOverlayEntry() {
//     final itemsWidths = _filteredItems
//         .map((item) => _calculateTextWidth(widget.itemLabel(item)))
//         .toList();
//     final double maxWidth = itemsWidths.isNotEmpty
//         ? itemsWidths.reduce((a, b) => a > b ? a : b)
//         : 100;

//     return OverlayEntry(
//       builder: (context) => Positioned(
//         child: CompositedTransformFollower(
//           link: _layerLink,
//           offset: const Offset(0, 40),
//           showWhenUnlinked: false,
//           child: Material(
//             elevation: 4,
//             borderRadius: BorderRadius.circular(8),
//             child: ConstrainedBox(
//               constraints: BoxConstraints(
//                 maxHeight: 200,
//                 minWidth: maxWidth,
//                 maxWidth: maxWidth,
//               ),
//               child: ListView.builder(
//                 padding: EdgeInsets.zero,
//                 shrinkWrap: true,
//                 itemCount: _filteredItems.length,
//                 itemBuilder: (context, index) {
//                   final item = _filteredItems[index];
//                   return ListTile(
//                     title: Text(widget.itemLabel(item)),
//                     onTap: () {
//                       setState(() {
//                         _selectedItem = item;
//                         _controller.text = _displaySelected(item);
//                         _searchQuery = '';
//                       });
//                       widget.onSelect(item);
//                       _removeOverlay();
//                       _focusNode.unfocus();
//                     },
//                   );
//                 },
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     final fieldWidth = _calculateTextWidth(
//       _selectedItem != null
//           ? _displaySelected(_selectedItem as T)
//           : widget.placeholder,
//     );

//     return CompositedTransformTarget(
//       link: _layerLink,
//       child: SizedBox(
//         width: fieldWidth,
//         child: TextFormField(
//           controller: _controller,
//           focusNode: _focusNode,
//           readOnly: !widget.searchable,
//           decoration: InputDecoration(
//             hintText: _selectedItem == null ? widget.placeholder : null,
//             border: const OutlineInputBorder(),
//             suffixIcon: widget.icon
//                 ? (_focusNode.hasFocus && widget.searchable
//                     ? IconButton(
//                         icon: const Icon(Icons.clear),
//                         onPressed: () {
//                           setState(() {
//                             _controller.clear();
//                             _searchQuery = '';
//                             _selectedItem = null;
//                           });
//                           widget.onSelect(null);
//                         },
//                       )
//                     : const Icon(Icons.arrow_drop_down))
//                 : null,
//           ),
//           validator: (value) {
//             if (widget.validator != null) {
//               return widget.validator!(_selectedItem);
//             }
//             return null;
//           },
//           onChanged: (value) {
//             if (widget.searchable) {
//               setState(() => _searchQuery = value);
//               _removeOverlay();
//               _showOverlay();
//             }
//           },
//           onTap: () {
//             if (_overlayEntry == null) {
//               _showOverlay();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
