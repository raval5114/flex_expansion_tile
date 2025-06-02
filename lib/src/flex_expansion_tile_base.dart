import 'package:flutter/material.dart';

class FlexExpansionTile extends StatefulWidget {
  final Widget title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final ValueChanged<bool>? onExpansionChanged;
  final VoidCallback? onChildInteraction;

  // 🎨 Decoration properties
  final Color? backgroundColor;
  final BorderRadiusGeometry? borderRadius;
  final BoxBorder? border;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? elevation;

  const FlexExpansionTile({
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
    this.onExpansionChanged,
    this.onChildInteraction,
    this.backgroundColor,
    this.borderRadius,
    this.border,
    this.padding,
    this.margin,
    this.elevation,
    Key? key,
  }) : super(key: key);

  @override
  State<FlexExpansionTile> createState() => _FlexExpansionTileState();
}

class _FlexExpansionTileState extends State<FlexExpansionTile>
    with SingleTickerProviderStateMixin {
  late bool _isExpanded;
  late AnimationController _controller;
  late Animation<double> _iconTurns;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;

    _controller = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    _iconTurns = Tween<double>(begin: 0.0, end: 0.5).animate(_controller);

    if (_isExpanded) _controller.value = 0.5;
  }

  void _handleExpansion(bool expanded) {
    setState(() {
      _isExpanded = expanded;
      if (_isExpanded) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    });
    widget.onExpansionChanged?.call(expanded);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final container = Container(
      margin: widget.margin,
      padding: widget.padding,
      decoration: BoxDecoration(
        color: widget.backgroundColor ?? Theme.of(context).cardColor,
        borderRadius: widget.borderRadius ?? BorderRadius.circular(12),
        border: widget.border,
        boxShadow:
            widget.elevation != null
                ? [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: widget.elevation!,
                    offset: const Offset(0, 2),
                  ),
                ]
                : null,
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: EdgeInsets.zero,
          title: widget.title,
          initiallyExpanded: widget.initiallyExpanded,
          onExpansionChanged: _handleExpansion,
          trailing: RotationTransition(
            turns: _iconTurns,
            child: const Icon(Icons.arrow_drop_down),
          ),
          children:
              widget.children
                  .map(
                    (child) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: widget.onChildInteraction,
                      child: child,
                    ),
                  )
                  .toList(),
        ),
      ),
    );

    return container;
  }
}
