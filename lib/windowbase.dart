library windowbase;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

///Class that receive many windows as children
class WindowBase extends StatefulWidget {
  WindowBase({
    @required this.windows,
    this.body,
  });

  ///List of Window widgets that will stay over the body
  ///
  ///The windows will be stacked in the order of the List, just like a Stack
  final List<Window> windows;

  ///A optional widget that will stay behind the windows
  final Widget body;

  @override
  _WindowBaseState createState() => _WindowBaseState();
}

class _WindowBaseState extends State<WindowBase> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Container(
            child: Center(
              child: Container(
                width: constraints.maxWidth,
                height: constraints.maxHeight,
                decoration: BoxDecoration(
                  color: Theme.of(context).scaffoldBackgroundColor,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Positioned.fill(
                      child: Container(
                        color: Theme.of(context).scaffoldBackgroundColor,
                      ),
                    ),
                    if (widget.body != null) widget.body,
                    if (widget.windows != null) ...widget.windows,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

enum _TargetType { Left, Right, Top }

class _WindowTarget extends StatelessWidget {
  _WindowTarget({
    @required this.maxSize,
    @required this.type,
  });

  final Size maxSize;
  final _TargetType type;

  @override
  Widget build(BuildContext context) {
    var top;
    var left;
    var height;
    var width;
    switch (type) {
      case _TargetType.Left:
        top = 0.0;
        left = 0.0;
        height = maxSize.height;
        width = maxSize.width / 2;
        break;
      case _TargetType.Right:
        top = 0.0;
        left = maxSize.width / 2;
        height = maxSize.height;
        width = maxSize.width / 2;
        break;
      case _TargetType.Top:
        top = 0.0;
        left = 0.0;
        height = maxSize.height;
        width = maxSize.width;
        break;
    }
    return Positioned(
      top: top,
      left: left,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(
          color: Colors.black12,
          border: Border.all(
            color: Colors.black26,
          ),
        ),
      ),
    );
  }
}

/// A Widget that create a window floating, the parent needs to have a finity size and works better inside a WindowsBase widget
class Window extends StatefulWidget {
  Window({
    Key key,
    this.child,
    this.borderColor,
    this.boundConstraints = true,
    this.height = 300,
    this.width = 200,
    this.borderThickness = 3,
    this.elevation = 3,
    this.position,
    this.title,
    this.menuButtons = false,
    this.minimized = false,
    this.minimizeColor,
    this.maximizeColor,
    this.closeColor,
    this.closeIcon,
    this.maximizeIcon,
    this.minimizeIcon,
    this.titleHeight,
    this.restoreIcon,
    this.showClose = true,
    this.resizeble = true,
    this.draggable = true,
    this.onClose,
    this.onTap,
    this.refreshOnUpdate = false,
  }) : super(key: key);

  ///The color of windows border
  ///
  ///If null will get the the primary color of Theme
  final Color borderColor;

  ///The thickness of the window border,
  ///
  ///The size is inside the height and widht of the window
  ///
  ///If null will be 3
  final double borderThickness;

  ///Define if the window can overpass the size of his parent when dragged or resized
  ///
  ///If true the window will be replaced and resized if the parent change his size to adapt to the new size
  ///
  ///If false in case of the parent be resized the window can stay off the screen entirely
  final bool boundConstraints;

  ///The height of the window
  ///
  ///This property will not be updated unless refreshOnUpdate be true
  ///
  ///If null will be setted to 200, it will not get the children size and can cause overflow if the window size is below the child size
  final double width;

  ///The height of the height
  ///
  ///This property will not be updated unless refreshOnUpdate be true
  ///
  ///If null will be setted to 300, it will not get the children size and can cause overflow if the window size is below the child size
  final double height;

  ///The elevation of the window over the base
  ///
  ///If null it will be set to 3
  final int elevation;

  ///The position in absolute offset of the screen
  ///
  ///This property will not be updated unless refreshOnUpdate be true
  final Offset position;

  ///A String to be showed like a text in the top bar of the window
  ///
  ///It will use the Theme subtitle2
  final String title;

  ///Define the height of the title bar
  ///
  ///If null will be set to 20
  final double titleHeight;

  ///Show the menuButtons to minimize, restore and close
  final bool menuButtons;

  ///The status of the window
  ///
  ///This property will not be updated unless refreshOnUpdate be true
  final bool minimized;

  ///The color of minimize button
  ///
  ///If null will get the the accent color of Theme
  final Color minimizeColor;

  ///The color of maximize button
  ///
  ///If null will get the the accent color of Theme
  final Color maximizeColor;

  ///The color of close button
  ///
  ///If null will get the the accent color of Theme
  final Color closeColor;

  ///The icon of minimize button
  ///
  ///If null will be minimize of material icons
  final IconData minimizeIcon;

  ///The icon of maximize button
  ///
  ///If null will be maximize of material icons
  final IconData maximizeIcon;

  ///The icon of close button
  ///
  ///If null will be close of material icons
  final IconData closeIcon;

  ///The icon of restore button
  ///
  ///If null will be restore of material icons
  final IconData restoreIcon;

  ///A widget to be showed inside the window
  final Widget child;

  ///An option to hide the close button
  final bool showClose;

  ///Permission to resize the window
  final bool resizeble;

  ///Permission to drag and change the position of the window
  final bool draggable;

  ///A callback in case the button close is tapped
  final Function onClose;

  ///A callback in case the window receive a tap
  ///
  ///This callback is useful to reorder your List of windows to pass the tapped window to the front
  final Function onTap;

  ///The position, height, widht e minimize are setted dinamic by a window controller,
  ///
  ///If false (standard) the state of window will not affect these properties,
  ///you can change a state of a window and will stay with sizes and positions
  ///
  ///If true, when the state of window update these properties will setted again to the valors in the constructor
  final bool refreshOnUpdate;

  @override
  _WindowState createState() => _WindowState();
}

class _WindowState extends State<Window> {
  _WindowController controller;
  Size maxSize;
  List<_WindowTarget> targets;
  _TargetType currentTarget;

  @override
  void initState() {
    controller = _WindowController(
      position: widget.position ?? Offset(10, 10),
      minimized: widget.minimized ?? false,
      width: widget.width ?? 200,
      height: widget.height ?? 300,
    )..addListener(() {
        setState(() {});
      });
    super.initState();
  }

  @override
  void didUpdateWidget(covariant Window oldWidget) {
    print('updated');
    if (widget.refreshOnUpdate) {
      controller.dispose();
      controller = null;
      controller = _WindowController(
        position: widget.position ?? Offset(10, 10),
        minimized: widget.minimized ?? false,
        width: widget.width ?? 200,
        height: widget.height ?? 300,
      )..addListener(() {
          setState(() {});
        });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  _getTargets(Offset offset) {
    if (!controller.minimized) {
      setState(() {
        if (offset.dx <= 30) {
          currentTarget = _TargetType.Left;
        } else if (offset.dx >= maxSize.width - 30) {
          currentTarget = _TargetType.Right;
        } else if (offset.dy <= 15) {
          currentTarget = _TargetType.Top;
        } else {
          currentTarget = null;
        }
      });
    }
  }

  _resizeToTarget() {
    if (currentTarget != null && !controller.minimized) {
      switch (currentTarget) {
        case _TargetType.Left:
          controller.changeSizeHorizontal(
            maxSize.width / 2,
            maxSize: maxSize,
            midWidth: true,
          );
          controller.changeSizeVertical(
            maxSize.height,
            maxSize: maxSize,
            totalHeight: true,
          );
          controller.changePosition(
            newPosition: Offset(0, 0),
            maxSize: maxSize,
            bounded: true,
          );
          break;
        case _TargetType.Right:
          controller.changeSizeHorizontal(
            maxSize.width / 2,
            maxSize: maxSize,
            midWidth: true,
          );
          controller.changeSizeVertical(
            maxSize.height,
            maxSize: maxSize,
            totalHeight: true,
          );
          controller.changePosition(
              newPosition: Offset(maxSize.width / 2, 0),
              maxSize: maxSize,
              bounded: true);
          break;
        case _TargetType.Top:
          controller.changeSizeHorizontal(
            maxSize.width,
            maxSize: maxSize,
            totalWidth: true,
          );
          controller.changeSizeVertical(
            maxSize.height,
            maxSize: maxSize,
            totalHeight: true,
          );
          controller.changePosition(
            newPosition: Offset(0, 0),
            maxSize: maxSize,
            bounded: true,
          );
          break;
        default:
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (maxSize == null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        RenderBox box = context.findRenderObject() as RenderBox;
        if (box != null && box.hasSize) {
          maxSize = box.size;
        }
        if (targets == null || targets.isEmpty)
          targets = [
            _WindowTarget(
              type: _TargetType.Left,
              maxSize: maxSize,
            ),
            _WindowTarget(
              type: _TargetType.Right,
              maxSize: maxSize,
            ),
            _WindowTarget(
              type: _TargetType.Top,
              maxSize: maxSize,
            ),
          ];
      });
      return SizedBox(
        height: double.infinity,
        width: double.infinity,
      );
    }
    return LayoutBuilder(builder: (context, constraints) {
      var newMaxSize = Size(
        constraints.maxWidth,
        constraints.maxHeight,
      );
      if (newMaxSize != maxSize) {
        maxSize = newMaxSize;
        controller.changePosition(
          newPosition: controller.position,
          maxSize: maxSize,
          bounded: widget.boundConstraints,
        );
        targets = [
          _WindowTarget(
            type: _TargetType.Left,
            maxSize: maxSize,
          ),
          _WindowTarget(
            type: _TargetType.Right,
            maxSize: maxSize,
          ),
          _WindowTarget(
            type: _TargetType.Top,
            maxSize: maxSize,
          ),
        ];
      }
      return Stack(
        children: [
          if (currentTarget == _TargetType.Left) targets[0],
          if (currentTarget == _TargetType.Right) targets[1],
          if (currentTarget == _TargetType.Top) targets[2],
          Positioned(
              top: controller.position.dy,
              left: controller.position.dx,
              child: widget.draggable
                  ? GestureDetector(
                      child: _draggable(context, maxSize),
                      onPanEnd: (detail) {
                        _resizeToTarget();
                      },
                      onPanUpdate: (detail) {
                        _getTargets(detail.globalPosition);
                        controller.changePosition(
                          newPosition: detail.globalPosition,
                          maxSize: maxSize,
                          bounded: widget.boundConstraints,
                        );
                      },
                    )
                  : _draggable(context, maxSize)),
        ],
      );
    });
  }

  Widget _topMenu(BuildContext context, Size maxSize) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 3, horizontal: 10),
      alignment: Alignment.center,
      width: widget.titleHeight,
      height: widget.titleHeight,
      color: widget.borderColor,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Spacer(),
          if (widget.title != null)
            Text(
              widget.title,
              style: Theme.of(context).textTheme.subtitle2,
            ),
          if (!widget.menuButtons) Spacer(),
          if (widget.menuButtons) ...[
            Expanded(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (!controller.minimized)
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.minimizeColor ??
                              Theme.of(context).accentColor,
                        ),
                        child: Icon(
                          widget.minimizeIcon ?? Icons.minimize,
                          size: 10,
                        ),
                      ),
                      onTap: () {
                        controller.minimize();
                      },
                    ),
                  if (controller.minimized)
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.minimizeColor ??
                              Theme.of(context).accentColor,
                        ),
                        child: Icon(
                          widget.restoreIcon ?? Icons.crop_square,
                          size: 10,
                        ),
                      ),
                      onTap: () {
                        controller.restore();
                      },
                    ),
                  SizedBox(
                    width: 3,
                  ),
                  GestureDetector(
                    child: Container(
                      padding: EdgeInsets.all(1),
                      height: 15,
                      width: 15,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: widget.maximizeColor ??
                            Theme.of(context).accentColor,
                      ),
                      child: Icon(
                        widget.maximizeIcon ?? Icons.maximize,
                        size: 10,
                      ),
                    ),
                    onTap: () {
                      if (maxSize ==
                          Size(controller.width, controller.height)) {
                        controller.returnToBasicSize(maxSize);
                      } else {
                        controller.maximize(maxSize);
                      }
                    },
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  if (widget.showClose)
                    GestureDetector(
                      child: Container(
                        padding: EdgeInsets.all(1),
                        height: 15,
                        width: 15,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: widget.closeColor ??
                              Theme.of(context).accentColor,
                        ),
                        child: Icon(
                          widget.closeIcon ?? Icons.close,
                          size: 10,
                        ),
                      ),
                      onTap: () {
                        if (widget.onClose != null) widget.onClose();
                      },
                    ),
                ],
              ),
            )
          ],
        ],
      ),
    );
  }

  Widget _draggable(BuildContext context, Size maxSize) {
    var boderColorIn = widget.borderColor ?? Theme.of(context).primaryColor;
    if (controller.minimized) {
      return Container(
        constraints: BoxConstraints(
          minWidth: 200,
          minHeight: 20,
          maxHeight: 25,
          maxWidth: 200,
        ),
        decoration: BoxDecoration(
          color: boderColorIn,
          boxShadow: kElevationToShadow[widget.elevation],
          borderRadius: BorderRadius.circular(3),
        ),
        child: _topMenu(context, maxSize),
      );
    } else {
      return LayoutBuilder(
        builder: (context, constraints) {
          return Stack(
            children: [
              GestureDetector(
                onDoubleTap: () {
                  controller.returnToBasicSize(maxSize);
                },
                onTap: () {
                  print('onTap');
                  if (widget.onTap != null) widget.onTap();
                },
                child: Container(
                  padding: EdgeInsets.all(widget.borderThickness),
                  height: controller.height,
                  width: controller.width,
                  decoration: BoxDecoration(
                    color: boderColorIn,
                    boxShadow: kElevationToShadow[widget.elevation],
                    borderRadius: BorderRadius.circular(3),
                  ),
                  child: Column(
                    children: [
                      if (widget.title != null || widget.menuButtons)
                        _topMenu(
                          context,
                          maxSize,
                        ),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context).dialogBackgroundColor,
                            borderRadius: BorderRadius.circular(3),
                          ),
                          child: widget.child,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              if (widget.resizeble)
                Positioned(
                  bottom: 0,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeUpDown,
                    child: GestureDetector(
                      onVerticalDragUpdate: (detail) {
                        controller.changeSizeVertical(
                          detail.globalPosition.dy,
                          maxSize: maxSize,
                        );
                      },
                      child: Container(
                        height: widget.borderThickness + 5,
                        width: controller.width,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
              if (widget.resizeble)
                Positioned(
                  right: 0,
                  top: 0,
                  child: MouseRegion(
                    cursor: SystemMouseCursors.resizeLeftRight,
                    child: GestureDetector(
                      onHorizontalDragUpdate: (detail) {
                        controller.changeSizeHorizontal(
                            detail.globalPosition.dx,
                            maxSize: maxSize);
                      },
                      child: Container(
                        height: controller.height,
                        width: widget.borderThickness + 5,
                        color: Colors.transparent,
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      );
    }
  }
}

class _WindowController extends ChangeNotifier {
  Offset position;
  bool minimized;
  double width;
  double height;
  Size maxSize;
  int index;
  _WindowController({
    @required this.position,
    @required this.minimized,
    @required this.width,
    @required this.height,
  });

  changeSizeVertical(
    double newVerticalPosition, {
    bool totalHeight = false,
    @required Size maxSize,
  }) {
    final newSize = Size(
      width,
      totalHeight ? maxSize.height : newVerticalPosition - (position.dy),
    );
    if (newSize.height < 20) {
      height = 20;
    } else {
      height = newSize.height;
    }
    notifyListeners();
  }

  maximize(Size maxSize) {
    minimized = false;
    width = maxSize.width;
    height = maxSize.height;
    position = Offset.zero;
    notifyListeners();
  }

  returnToBasicSize(Size maxSize) {
    minimized = false;
    width = maxSize.width / 2;
    height = maxSize.height / 2;
    notifyListeners();
  }

  minimize() {
    minimized = true;
    notifyListeners();
  }

  restore() {
    minimized = false;
    notifyListeners();
  }

  changeSizeHorizontal(
    double newHorizontalPosition, {
    bool totalWidth = false,
    bool midWidth = false,
    @required Size maxSize,
  }) {
    final newSize = Size(
      totalWidth
          ? maxSize.width
          : midWidth
              ? maxSize.width / 2
              : (newHorizontalPosition) - position.dx,
      height,
    );
    if (newSize.width < 20) {
      width = 20;
    } else {
      width = newSize.width;
    }
    notifyListeners();
  }

  changePosition({
    @required Offset newPosition,
    @required Size maxSize,
    @required bool bounded,
    bool notReconstruct = false,
  }) {
    if (bounded) {
      double x = 0;
      double y = 0;
      newPosition.dx < 0 ? x = 0 : x = newPosition.dx;
      newPosition.dy < 0 ? y = 0 : y = newPosition.dy;
      if (!minimized) {
        if (x + width > maxSize.width) x = maxSize.width - width;
        if (y + height > maxSize.height) y = maxSize.height - height;
      }
      position = Offset(x, y);
    } else {
      position = newPosition;
    }
    if (notReconstruct) notifyListeners();
  }
}
