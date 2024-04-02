import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class StackCard extends StatefulWidget {
  final List<StackCardItem> children;
  final Duration duration;
  final double originalAngle;
  final double transformAngle;
  final double topMargin;

  const StackCard(
      {super.key,
      required this.children,
      this.duration = const Duration(milliseconds: 300),
      this.originalAngle = 0.6,
      this.transformAngle = 0.9,
      this.topMargin = 60});
  @override
  State<StackCard> createState() => _StackCardState();
}

class _StackCardState extends State<StackCard> with TickerProviderStateMixin {
  final List<AnimationController> _controller = [];
  final List<Animation<double>> _angleController = [];
  @override
  void initState() {
    super.initState();
    for (var i = 0; i < widget.children.length; i++) {
      _controller
          .add(AnimationController(duration: widget.duration, vsync: this));
      _angleController.add(Tween<double>(
              begin: widget.originalAngle, end: widget.transformAngle)
          .animate(
              CurvedAnimation(parent: _controller[i], curve: Curves.linear)));
      if (kDebugMode) {
        print("adding");
      }
    }
  }

  @override
  void dispose() {
    for (var ctrl in _controller) {
      ctrl.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int count = 1;
    return Stack(
      alignment: Alignment.center,
      children: widget.children.map(
        (child) {
          final idx = widget.children.indexOf(child);
          if (kDebugMode) {
            print(_angleController[idx]);
          }
          count++;
          return Positioned(
              top: widget.topMargin * count,
              height: child.height,
              child: AnimatedBuilder(
                  animation: _controller[idx],
                  builder: (ctx, _) {
                    return Transform(
                      transform: () {
                        Matrix4 m = Matrix4.rotationX(1);
                        m.rotateZ(_angleController[idx].value);
                        return m;
                      }(),
                      child: InkWell(
                        splashColor: Colors.transparent,
                        highlightColor: Colors.transparent,
                        onTap: () {
                          if (kDebugMode) {
                            print(_controller);
                          }
                          if (_controller[idx].status ==
                                  AnimationStatus.forward ||
                              _controller[idx].status ==
                                  AnimationStatus.completed) {
                            _controller[idx].reverse();
                          } else {
                            _controller[idx].forward(from: 0);
                          }
                          if (child.onTap != null) {
                            child.onTap!();
                          }
                        },
                        child: child,
                      ),
                    );
                  }));
        },
      ).toList(),
    );
  }
}

class StackCardItem extends StatelessWidget {
  final Decoration? decoration;
  final Widget child;
  final double? width;
  final double? height;
  final void Function()? onTap;
  const StackCardItem(
      {super.key,
      this.decoration,
      required this.child,
      this.onTap,
      this.width,
      this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: decoration,
      child: child,
    );
  }
}
