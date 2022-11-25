import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:hometanding/utils.dart';

class SpinningWheel extends StatefulWidget {
  final double width;
  final double height;
  final Image image;
  final int dividers;
  final double initialSpinAngle;
  final double spinResistance;
  final bool canInteractWhileSpinning;
  final Image secondaryImage;
  final double secondaryImageHeight;
  final double secondaryImageWidth;
  final double secondaryImageTop;
  final double secondaryImageLeft;
  final Function onUpdate;
  final Function onEnd;
  final Stream shouldStartOrStop;

  SpinningWheel(
    this.image, {
    @required this.width,
    @required this.height,
    @required this.dividers,
    this.initialSpinAngle = 0.0,
    this.spinResistance = 0.5,
    this.canInteractWhileSpinning: true,
    this.secondaryImage,
    this.secondaryImageHeight,
    this.secondaryImageWidth,
    this.secondaryImageTop,
    this.secondaryImageLeft,
    this.onUpdate,
    this.onEnd,
    this.shouldStartOrStop,
  })  : assert(width > 0.0 && height > 0.0),
        assert(spinResistance > 0.0 && spinResistance <= 1.0),
        assert(initialSpinAngle >= 0.0 && initialSpinAngle <= (2 * pi)),
        assert(secondaryImage == null ||
            (secondaryImageHeight <= height && secondaryImageWidth <= width));

  @override
  _SpinningWheelState createState() => _SpinningWheelState();
}

class _SpinningWheelState extends State<SpinningWheel>
    with SingleTickerProviderStateMixin {
  AnimationController _animationController;
  Animation<double> _animation;
  SpinVelocity _spinVelocity;
  NonUniformCircularMotion _motion;
  Offset _localPositionOnPanUpdate;
  double _totalDuration = 0;
  double _initialCircularVelocity = 0;
  double _dividerAngle;
  double _currentDistance = 0;
  double _initialSpinAngle;
  int _currentDivider;
  bool _isBackwards;
  DateTime _offsetOutsideTimestamp;
  RenderBox _renderBox;
  StreamSubscription _subscription;

  @override
  void initState() {
    super.initState();

    _spinVelocity = SpinVelocity(width: widget.width, height: widget.height);
    _motion = NonUniformCircularMotion(resistance: widget.spinResistance);

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 0),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _animationController, curve: Curves.linear));

    _dividerAngle = _motion.anglePerDivision(widget.dividers);
    _initialSpinAngle = widget.initialSpinAngle;

    _animation.addStatusListener((status) {
      // _animationStatus = status;
      if (status == AnimationStatus.completed) _stopAnimation();
    });

    if (widget.shouldStartOrStop != null) {
      _subscription = widget.shouldStartOrStop.listen(_startOrStop);
    }
  }

  _startOrStop(dynamic velocity) {
    if (_animationController.isAnimating) {
      _stopAnimation();
    } else {
      // velocity is pixels per second in axis Y
      // we asume a drag from cuadrant 1 with high velocity (8000)
      var pixelsPerSecondY = velocity ?? 8000.0;
      _localPositionOnPanUpdate = Offset(250.0, 250.0);
      _startAnimation(Offset(0.0, pixelsPerSecondY));
    }
  }

  double get topSecondaryImage =>
      widget.secondaryImageTop ??
      (widget.height / 2) - (widget.secondaryImageHeight / 2);

  double get leftSecondaryImage =>
      widget.secondaryImageLeft ??
      (widget.width / 2) - (widget.secondaryImageWidth / 2);

  double get widthSecondaryImage => widget.secondaryImageWidth ?? widget.width;

  double get heightSecondaryImage =>
      widget.secondaryImageHeight ?? widget.height;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      width: widget.width,
      child: Stack(
        children: [
          GestureDetector(
            onPanUpdate: _moveWheel,
            onPanEnd: _startAnimationOnPanEnd,
            onPanDown: (_details) => _stopAnimation(),
            child: AnimatedBuilder(
                animation: _animation,
                child: Container(child: widget.image),
                builder: (context, child) {
                  _updateAnimationValues();
                  widget.onUpdate(_currentDivider);
                  return Transform.rotate(
                    angle: _initialSpinAngle + _currentDistance,
                    child: child,
                  );
                }),
          ),
          widget.secondaryImage != null
              ? Positioned(
                  top: topSecondaryImage,
                  left: leftSecondaryImage,
                  child: SizedBox(
                    height: heightSecondaryImage,
                    width: widthSecondaryImage,
                    child: widget.secondaryImage,
                  ))
              : Container(),
        ],
      ),
    );
  }

  // user can interact only if widget allows or wheel is not spinning
  bool get _userCanInteract =>
      !_animationController.isAnimating || widget.canInteractWhileSpinning;

  // transforms from global coordinates to local and store the value
  void _updateLocalPosition(Offset position) {
    _renderBox ??= context.findRenderObject();
    _localPositionOnPanUpdate = _renderBox.globalToLocal(position);
  }

  /// returns true if (x,y) is outside the boundaries from size
  bool _contains(Offset p) => Size(widget.width, widget.height).contains(p);

  // this is called just before the animation starts
  void _updateAnimationValues() {
    if (_animationController.isAnimating) {
      // calculate total distance covered
      var currentTime = _totalDuration * _animation.value;
      _currentDistance =
          _motion.distance(_initialCircularVelocity, currentTime);
      if (_isBackwards) {
        _currentDistance = -_currentDistance;
      }
    }
    // calculate current divider selected
    var modulo = _motion.modulo(_currentDistance + _initialSpinAngle);
    _currentDivider = widget.dividers - (modulo ~/ _dividerAngle);
    if (_animationController.isCompleted) {
      _initialSpinAngle = modulo;
      _currentDistance = 0;
    }
  }

  void _moveWheel(DragUpdateDetails details) {
    if (!_userCanInteract) return;

    // user won't be able to get back in after dragin outside
    if (_offsetOutsideTimestamp != null) return;

    _updateLocalPosition(details.globalPosition);

    if (_contains(_localPositionOnPanUpdate)) {
      // we need to update the rotation
      // so, calculate the new rotation angle and rebuild the widget
      var angle = _spinVelocity.offsetToRadians(_localPositionOnPanUpdate);
      setState(() {
        // initialSpinAngle will be added later on build
        _currentDistance = angle - _initialSpinAngle;
      });
    } else {
      // if user dragged outside the boundaries we save the timestamp
      // when user releases the drag, it will trigger animation only if less than duration time passed from now
      _offsetOutsideTimestamp = DateTime.now();
    }
  }

  void _stopAnimation() {
    if (!_userCanInteract) return;

    _offsetOutsideTimestamp = null;
    _animationController.stop();
    _animationController.reset();

    widget.onEnd(_currentDivider);
  }

  void _startAnimationOnPanEnd(DragEndDetails details) {
    if (!_userCanInteract) return;

    if (_offsetOutsideTimestamp != null) {
      var difference = DateTime.now().difference(_offsetOutsideTimestamp);
      _offsetOutsideTimestamp = null;
      // if more than 50 seconds passed since user dragged outside the boundaries, dont start animation
      if (difference.inMilliseconds > 50) return;
    }

    // it was the user just taping to stop the animation
    if (_localPositionOnPanUpdate == null) return;

    _startAnimation(details.velocity.pixelsPerSecond);
  }

  void _startAnimation(Offset pixelsPerSecond) {
    var velocity =
        _spinVelocity.getVelocity(_localPositionOnPanUpdate, pixelsPerSecond);

    _localPositionOnPanUpdate = null;
    _isBackwards = velocity < 0;
    _initialCircularVelocity = pixelsPerSecondToRadians(velocity.abs());
    _totalDuration = _motion.duration(_initialCircularVelocity);

    _animationController.duration =
        Duration(milliseconds: (_totalDuration * 1000).round());

    _animationController.reset();
    _animationController.forward();
  }

  dispose() {
    _animationController.dispose();
    if (_subscription != null) {
      _subscription.cancel();
    }
    super.dispose();
  }
}

class Roulette extends StatelessWidget {
  final StreamController _dividerController = StreamController<int>();

  final _wheelNotifier = StreamController<double>();

  dispose() {
    _dividerController.close();
    _wheelNotifier.close();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("지옥의 섯다"),
        backgroundColor: Color(0xFF2DA30D),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinningWheel(
              Image.asset('assets/roulette.png'),
              width: 310,
              height: 310,
              initialSpinAngle: _generateRandomAngle(),
              spinResistance: 0.6,
              canInteractWhileSpinning: false,
              dividers: 8,
              onUpdate: _dividerController.add,
              onEnd: _dividerController.add,
              secondaryImage: Image.asset('assets/roulette-center-300.png'),
              secondaryImageHeight: 110,
              secondaryImageWidth: 110,
              shouldStartOrStop: _wheelNotifier.stream,
            ),
            SizedBox(height: 30),
            StreamBuilder(
              stream: _dividerController.stream,
              builder: (context, snapshot) =>
                  snapshot.hasData ? RouletteScore(snapshot.data) : Container(),
            ),
            SizedBox(height: 30),
            TextButton(
              child: Text("Start"),
              onPressed: () =>
                  _wheelNotifier.sink.add(_generateRandomVelocity()),
            )
          ],
        ),
      ),
    );
  }

  double _generateRandomVelocity() => (Random().nextDouble() * 6000) + 4000;

  double _generateRandomAngle() => Random().nextDouble() * pi * 2;
}

class RouletteScore extends StatelessWidget {
  final int selected;

  final Map<int, String> labels = {
    1: '한 잔',
    2: '두 잔',
    3: '양 옆 한잔',
    4: '왼쪽 한잔',
    5: '두 잔',
    6: '한 잔',
    7: '오른쪽 한잔',
    8: '통과',
  };

  RouletteScore(this.selected);

  @override
  Widget build(BuildContext context) {
    return Text('${labels[selected]}',
        style: TextStyle(fontStyle: FontStyle.italic, fontSize: 24.0));
  }
}
