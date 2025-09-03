import 'package:ag_ticket/ui/components/my_container.dart';
import 'package:flutter/material.dart';

class HeaderScrollScreen extends StatefulWidget {
  final Widget header;
  final Widget child;
  final double maxHeaderHeight;
  final Function(double)? onHeightChanged;

  const HeaderScrollScreen({
    super.key,
    required this.header,
    required this.child,
    this.maxHeaderHeight = 70.0,
    this.onHeightChanged,
  });

  static void updateHeight(BuildContext context, double height) {
    final state = context.findAncestorStateOfType<_HeaderScrollScreenState>();
    state?.updateAdditionalHeight(height);
  }

  @override
  State<HeaderScrollScreen> createState() => _HeaderScrollScreenState();
}

class _HeaderScrollScreenState extends State<HeaderScrollScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;
  late Animation<double> _translateAnimation;
  double _lastOffset = 0.0;
  bool _isScrollingUp = false;
  double _additionalHeight = 0.0;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
      upperBound: 1,
      lowerBound: 0,
    );

    _opacityAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_animationController);
    _translateAnimation = Tween<double>(
            begin: 0.0, end: -(widget.maxHeaderHeight + _additionalHeight))
        .animate(_animationController);

    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    final offset = _scrollController.offset;

    if (offset > _lastOffset + 5) {
      if (_isScrollingUp) {
        _isScrollingUp = false;
        _animationController.forward();
      }
    } else if (offset < _lastOffset - 5) {
      if (!_isScrollingUp) {
        _isScrollingUp = true;
        _animationController.reverse();
      }
    }

    _lastOffset = offset;
  }

  void updateAdditionalHeight(double height) {
    setState(() {
      _additionalHeight = height;
      _translateAnimation = Tween<double>(
        begin: 0.0,
        end: -(widget.maxHeaderHeight + _additionalHeight),
      ).animate(_animationController);
      widget.onHeightChanged?.call(height);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animationController,
      builder: (context, _) {
        final double paddingTop = (widget.maxHeaderHeight + _additionalHeight) *
            (1.0 - _animationController.value);

        return Stack(
          children: [
            Padding(
              padding: EdgeInsets.only(top: paddingTop),
              child: SingleChildScrollView(
                controller: _scrollController,
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: widget.child,
              ),
            ),
            _opacityAnimation.value == 0
                ? const SizedBox.shrink()
                : Transform.translate(
                    offset: Offset(0, _translateAnimation.value),
                    child: FadeTransition(
                      opacity: _opacityAnimation,
                      child: MyContainer(
                        // height:
                        //     widget.maxHeaderHeight * 0.8 + _additionalHeight,
                        horizontalPadding: 4,
                        verticalPadding: 4,
                        radiusTopLeft: 0,
                        radiusTopRight: 0,
                        radiusBottomLeft: 4,
                        radiusBottomRight: 4,
                        color: Theme.of(context).colorScheme.secondary,
                        child: widget.header,
                      ),
                    ),
                  ),
          ],
        );
      },
    );
  }
}
