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
  late AnimationController _iconRotationController;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
    _iconRotationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
      value: _isExpanded ? 0.5 : 0.0,
    );
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded
          ? _iconRotationController.forward()
          : _iconRotationController.reverse();
    });
    widget.onExpansionChanged?.call(_isExpanded);
  }

  @override
  void dispose() {
    _iconRotationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          InkWell(
            onTap: _toggleExpansion,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: widget.title),
                RotationTransition(
                  turns: Tween<double>(
                    begin: 0.0,
                    end: 0.5,
                  ).animate(_iconRotationController),
                  child: const Icon(Icons.arrow_drop_down),
                ),
              ],
            ),
          ),
          AnimatedSize(
            duration: const Duration(milliseconds: 200),
            curve: Curves.easeInOut,
            child: ConstrainedBox(
              constraints:
                  _isExpanded
                      ? const BoxConstraints()
                      : const BoxConstraints(maxHeight: 0.0),
              child: Column(
                children:
                    widget.children.map((child) {
                      return GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: widget.onChildInteraction,
                        child: child,
                      );
                    }).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
