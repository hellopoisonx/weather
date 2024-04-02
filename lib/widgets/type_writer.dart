import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class Typewriter extends StatefulWidget {
  final String text; //要显示的文本
  final TextStyle styleNormal; //文本的样式
  final TextStyle styleLast; //文本的样式
  final Curve curve;
  final Duration duration; //打字效果的持续时间

  const Typewriter({
    super.key,
    required this.text,
    this.styleNormal = const TextStyle(),
    required this.styleLast,
    this.duration = const Duration(milliseconds: 30),
    this.curve = Curves.linear,
  });

  @override
  State<Typewriter> createState() => _TypewriterState();
}

class _TypewriterState extends State<Typewriter>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller; //动画控制器
  late Animation<int> _characterCount; //用于控制当前显示的字符数量

  @override
  void initState() {
    super.initState();

    //初始化AnimationController，指定动画的持续时间
    _controller = AnimationController(
      duration: widget.duration * widget.text.length,
      vsync: this,
    );

    //根据输入的文本长度，初始化一个IntTween，作为Controller的动画
    _characterCount =
        StepTween(begin: 0, end: widget.text.length).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    ));
    _controller.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (BuildContext context, Widget? child) {
        if (_characterCount.value < 1) {
          return const Text("");
        }
        String txt = widget.text.substring(0, _characterCount.value);
        if (kDebugMode) {
          print("${_characterCount.value} txt: $txt");
        }
        return SizedBox(
          width: double.infinity,
          child: RichText(
              text: TextSpan(
            style: widget.styleNormal,
            children: [
              TextSpan(text: txt.substring(0, txt.length - 1)),
              TextSpan(
                text: txt.isNotEmpty ? txt.substring(txt.length - 1) : '',
                style: widget.styleLast,
              ),
            ],
          )),
        );
      },
    );
  }

  @override
  void dispose() {
    _controller.dispose(); //用完检查Controller别忘记dispose
    super.dispose();
  }
}
