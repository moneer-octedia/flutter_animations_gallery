import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_animations_gallery/animation_controller_state.dart';
import 'package:flutter_animations_gallery/page_scaffold.dart';

final allCurves = <String, Curve>{
  'linear': Curves.linear,
  'decelerate': Curves.decelerate,
  'fastLinearToSlowEaseIn': Curves.fastLinearToSlowEaseIn,
  'ease': Curves.ease,
  'easeIn': Curves.easeIn,
  'easeInToLinear': Curves.easeInToLinear,
  'easeInSine': Curves.easeInSine,
  'easeInQuad': Curves.easeInQuad,
  'easeInCubic': Curves.easeInCubic,
  'easeInQuart': Curves.easeInQuart,
  'easeInQuint': Curves.easeInQuint,
  'easeInExpo': Curves.easeInExpo,
  'easeInCirc': Curves.easeInCirc,
  'easeInBack': Curves.easeInBack,
  'easeOut': Curves.easeOut,
  'linearToEaseOut': Curves.linearToEaseOut,
  'easeOutSine': Curves.easeOutSine,
  'easeOutQuad': Curves.easeOutQuad,
  'easeOutCubic': Curves.easeOutCubic,
  'easeOutQuart': Curves.easeOutQuart,
  'easeOutQuint': Curves.easeOutQuint,
  'easeOutExpo': Curves.easeOutExpo,
  'easeOutCirc': Curves.easeOutCirc,
  'easeOutBack': Curves.easeOutBack,
  'easeInOut': Curves.easeInOut,
  'easeInOutSine': Curves.easeInOutSine,
  'easeInOutQuad': Curves.easeInOutQuad,
  'easeInOutCubic': Curves.easeInOutCubic,
  'easeInOutQuart': Curves.easeInOutQuart,
  'easeInOutQuint': Curves.easeInOutQuint,
  'easeInOutExpo': Curves.easeInOutExpo,
  'easeInOutCirc': Curves.easeInOutCirc,
  'easeInOutBack': Curves.easeInOutBack,
  'fastOutSlowIn': Curves.fastOutSlowIn,
  'slowMiddle': Curves.slowMiddle,
  'bounceIn': Curves.bounceIn,
  'bounceOut': Curves.bounceOut,
  'bounceInOut': Curves.bounceInOut,
  'elasticIn': Curves.elasticIn,
  'elasticOut': Curves.elasticOut,
  'elasticInOut': Curves.elasticInOut,
};

class CurvesPage extends StatefulWidget {
  const CurvesPage({Key? key}) : super(key: key);

  @override
  _CurvesPageState createState() =>
      _CurvesPageState(Duration(milliseconds: 1500));
}

class _CurvesPageState extends AnimationControllerState<CurvesPage> {
  _CurvesPageState(Duration duration) : super(duration);
  int _selectedIndex = 0;
  bool _animateAllCurves = false;

  @override
  void initState() {
    super.initState();
    animationController.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return PageScaffold(
      title: 'Curves',
      actions: [
        IconButton(
            // TODO: Improve icons
            icon: Transform.rotate(
              angle: _animateAllCurves ? pi / 2 : 0,
              child: Icon(_animateAllCurves ? Icons.bar_chart : Icons.repeat),
            ),
            onPressed: () =>
                setState(() => _animateAllCurves = !_animateAllCurves)),
      ],
      body: ListView.separated(
        itemCount: allCurves.keys.length,
        itemBuilder: (context, index) {
          final curveKey = allCurves.keys.toList()[index];
          return CurveListTile(
            curve: allCurves[curveKey]!,
            curveName: curveKey,
            showAnimation: _animateAllCurves || index == _selectedIndex,
            animation: animationController,
            onSelected: () => setState(() => _selectedIndex = index),
          );
        },
        separatorBuilder: (context, index) => Container(
          color: Colors.black12,
          height: 0.5,
        ),
      ),
    );
  }
}

class CurveListTile extends StatelessWidget {
  CurveListTile({
    Key? key,
    required this.curve,
    required this.curveName,
    required this.showAnimation,
    required this.animation,
    this.onSelected,
  })  : curvedAnimation = tween.animate(CurvedAnimation(
          parent: animation,
          curve: curve,
        )),
        super(key: key);
  final Curve curve;
  final String curveName;
  final bool showAnimation;
  final Animation<double> animation;
  final Animation<double> curvedAnimation;
  final VoidCallback? onSelected;

  static final tween = Tween(begin: 0.0, end: 1.0);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Stack(children: [
        // only apply animation to selected item
        if (showAnimation)
          IgnorePointer(
            ignoring: true,
            child: AnimatedBuilder(
              animation: curvedAnimation,
              child: Container(color: Theme.of(context).primaryColor),
              builder: (context, child) {
                return FractionallySizedBox(
                  widthFactor: min(max(curvedAnimation.value, 0.0), 1.0),
                  child: child,
                );
              },
            ),
          ),
        Center(child: Text(curveName)),
        GestureDetector(
          onTap: onSelected,
          child: Container(
            height: 60,
            color: Colors.transparent,
          ),
        ),
      ]),
    );
  }
}