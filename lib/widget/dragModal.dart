import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../services/user-controller.dart';

// Partially visible bottom sheet that can be dragged into the screen. Provides different views for expanded and collapsed states
class DraggableBottomSheet extends StatefulWidget {
  /// Alignment of the sheet. Default Alignment.bottomCenter
  final Alignment alignment;

  /// Widget above which draggable sheet will be placed.
  final Widget backgroundWidget;

  /// Color of the modal barrier. Default Colors.black54
  final Color barrierColor;

  /// Whether tapping on the barrier will dismiss the dialog. Default true.
  /// If false, draggable bottom sheet will act as persistent sheet
  final bool barrierDismissible;

  /// Whether the sheet is collapsed initially. Default true.
  final bool collapsed;

  /// Sheet expansion animation curve. Default Curves.linear
  final Curve curve;

  /// Duration for sheet expansion animation. Default Duration(milliseconds: 0)
  final Duration duration;

  /// Widget to show on expended sheet
  final Widget expandedWidget;

  /// Increment [expansionExtent] on [minExtent] to change from [previewWidget] to [expandedWidget]
  final double expansionExtent;

  /// Maximum extent for sheet expansion
  final double maxExtent;

  /// Minimum extent for the sheet
  final double minExtent;

  /// Callback function when sheet is being dragged
  /// pass current extent (position) as an argument
  final Function(double) onDragging;

  /// Widget to show on collapsed sheet
  final Widget previewWidget;

  /// indicate if the dialog should only display in 'safe' areas of the screen. Default true
  final bool useSafeArea;

  final controller;

  const DraggableBottomSheet({
    Key? key,
    required this.previewWidget,
    required this.backgroundWidget,
    required this.expandedWidget,
    required this.onDragging,
    this.minExtent = 50.0,
    this.collapsed = true,
    this.useSafeArea = true,
    this.curve = Curves.linear,
    this.expansionExtent = 10.0,
    this.barrierDismissible = true,
    this.maxExtent = double.infinity,
    this.barrierColor = Colors.black54,
    required this.controller,
    this.alignment = Alignment.bottomCenter,

    this.duration = const Duration(milliseconds: 0),
  })  : assert(minExtent > 0.0),
        assert(expansionExtent > 0.0),
        assert(minExtent + expansionExtent < maxExtent),
        super(key: key);

  @override
  DraggableBottomSheetState createState() => DraggableBottomSheetState();
}

class DraggableBottomSheetState extends State<DraggableBottomSheet> {
  double _currentExtent = 0.0;
  bool isdrag = false;

  @override
  void initState() {
    super.initState();
    _currentExtent = widget.collapsed ? widget.minExtent : widget.maxExtent;
  }

  @override
  Widget build(BuildContext context) {
    return widget.useSafeArea ? SafeArea(child: _body()) : _body();
  }

  /// body content
  Widget _body() {
    return Stack(
      children: [
        // background widget
        widget.backgroundWidget,
        // barrier
        if (_currentExtent.roundToDouble() > widget.minExtent + 2)
          Positioned.fill(child: _barrier()),
        // sheet
        Align(alignment: widget.alignment, child: _sheet()),
      ],
    );
  }

  /// barrier film between sheet & background widget
  Widget _barrier() {
    return IgnorePointer(
      ignoring: !widget.barrierDismissible,
      child: GestureDetector(
        onTap: widget.barrierDismissible
            ? () => setState(() => _currentExtent = widget.minExtent)
            : null,
        child: Container(color: widget.barrierColor),
      ),
    );
  }

  /// draggable bottom sheet
  Widget _sheet() {
    return GestureDetector(
      onVerticalDragUpdate: _onVerticalDragUpdate,
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onVerticalDragEnd: _onVerticalDragEnd,
      child: AnimatedContainer(
        curve: widget.curve,
        // duration: widget.duration,
        duration: !isdrag?Duration(milliseconds:0):widget.duration,
        width: _axis() == Axis.horizontal ? _currentExtent : null,
        height: _axis() == Axis.horizontal ? null : _currentExtent,
        child: AnimatedSwitcher(
          switchOutCurve: Curves.bounceInOut,
          duration: Duration(milliseconds: 150),
          child: _currentExtent >= widget.minExtent + widget.expansionExtent
              ? widget.expandedWidget
              : widget.previewWidget,
        ),
      ),
    );
  }

  /// determine scroll direction based on DraggableBottomSheetPosition
  Axis _axis() {
    if (widget.alignment == Alignment.topLeft ||
        widget.alignment == Alignment.topRight ||
        widget.alignment == Alignment.topCenter ||
        widget.alignment == Alignment.bottomLeft ||
        widget.alignment == Alignment.bottomRight ||
        widget.alignment == Alignment.bottomCenter) {
      return Axis.vertical;
    }

    return Axis.horizontal;
  }

  /// callback function when sheet is dragged horizontally
  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    if (_axis() == Axis.vertical) return;

    // delta dx is positive when dragged towards right &
    // negative when dragged towards left
    final newExtent = (_currentExtent + details.delta.dx).roundToDouble();
    if (newExtent >= widget.minExtent && newExtent <= widget.maxExtent) {
      setState(() => _currentExtent = newExtent);
      widget.onDragging(_currentExtent);
    }
  }

  /// callback function when sheet is dragged vertically
  void _onVerticalDragUpdate(DragUpdateDetails details) {
    if (_axis() == Axis.horizontal) return;

    // delta dy is positive when dragged downward &
    // negetive when dragged upward
    final newExtent = (_currentExtent - details.delta.dy).roundToDouble();
    if (newExtent >= widget.minExtent && newExtent <= widget.maxExtent) {
      setState(() => _currentExtent = newExtent);
      widget.onDragging(_currentExtent);
    }
  }
  void _onVerticalDragEnd(DragEndDetails details){
    // print(details.velocity);
    // final newExtent = (_currentExtent - ).roundToDouble();
    setState(() {
      isdrag = true;
    });
    print('end');
    print(isdrag);

    print(widget.maxExtent);
    print(_currentExtent);
    if(_currentExtent>=widget.maxExtent/1.5){
      setState(() => _currentExtent = widget.maxExtent);
      widget.controller.animateBack(1.0);
      widget.controller.reset();
      widget.onDragging(_currentExtent);
      Get.find<userController>().isScroll.value = false;


    }else{
      setState(() => _currentExtent = widget.minExtent);
      widget.controller.reset();
      widget.controller.animateBack(0.4);
      widget.onDragging(_currentExtent);
      Get.find<userController>().isScroll.value = true;

    }
  }


}

