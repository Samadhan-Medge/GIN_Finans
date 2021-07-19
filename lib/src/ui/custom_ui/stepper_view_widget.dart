
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

enum StepperViewStepState {
  /// A step that displays its index in its circle.
  indexed,

  /// A step that displays a pencil icon in its circle.
  editing,

  /// A step that displays a tick icon in its circle.
  complete,

  /// A step that is disabled and does not to react to taps.
  disabled,

  /// A step that is currently having an error. e.g. the user has submitted wrong
  /// input.
  error,
}

/// Defines the [Stepper]'s main axis.
enum StepperType {
  /// A vertical layout of the steps with their content in-between the titles.
  vertical,

  /// A horizontal layout of the steps with their content below the titles.
  horizontal,
}

const TextStyle _kStepStyle = TextStyle(
  fontSize: 20.0,
  color: Colors.black,
);
const Color _kCircleActiveLight = Colors.white;
const Color _kCircleActiveDark = Colors.black87;
const double _kStepSize = 48.0;

@immutable
class StepperViewStep {
   StepperViewStep({
    this.state = StepperViewStepState.indexed,
    this.isActive = false,
  }) :assert(state != null);

  /// The state of the step which determines the styling of its components
  /// and whether steps are interactive.
  StepperViewStepState state;
  final bool isActive;
}


class StepperView extends StatefulWidget {
  /// Creates a stepper from a list of steps.
  /// The [steps], [type], and [currentStep] arguments must not be null.
  const StepperView({
    Key? key,
    required this.steps,
    required this.physics,
    this.type = StepperType.horizontal,
    this.currentStep = 0,
    required this.onStepTapped,
    this.onStepContinue,
    this.onStepCancel,
    this.controlsBuilder,
  }) : assert(steps != null),
        assert(currentStep != null),
        assert(0 <= currentStep && currentStep < steps.length),
        super(key: key);

  /// The length of [steps] must not change.
  final List<StepperViewStep> steps;

  final ScrollPhysics physics;

  final StepperType type;

  final int currentStep;

  final ValueChanged<int> onStepTapped;
  final VoidCallback? onStepContinue;
  final VoidCallback? onStepCancel;


  final ControlsWidgetBuilder? controlsBuilder;

  @override
  _StepperState createState() => _StepperState();
}

class _StepperState extends State<StepperView> with TickerProviderStateMixin {
  List<GlobalKey>? _keys = null;
  final Map<int, StepperViewStepState> _oldStates = <int, StepperViewStepState>{};

  @override
  void initState() {
    super.initState();
    _keys = List<GlobalKey>.generate(
      widget.steps.length,
          (int i) => GlobalKey(),
    );
  }

  bool _isFirst(int index) {
    return index == 0;
  }

  bool _isLast(int index) {
    return widget.steps.length - 1 == index;
  }

  bool _isCurrent(int index) {
    return widget.currentStep == index;
  }

  bool _isDark() {
    return Theme.of(context).brightness == Brightness.dark;
  }


  Widget? _buildCircleChild(int index, bool oldState) {
    final StepperViewStepState? state = oldState ? _oldStates[index] : widget.steps[index].state;
    final bool isDarkActive = false;
    assert(state != null);
    switch (state) {
      case StepperViewStepState.indexed:
      case StepperViewStepState.disabled:
        return Text(
          '${index + 1}',
          style: isDarkActive ? _kStepStyle.copyWith(color: Colors.black) : _kStepStyle,
        );
      case StepperViewStepState.editing:
        return Icon(
          Icons.edit,
          color: isDarkActive ? _kCircleActiveDark : _kCircleActiveLight,
          size: 18.0,
        );
      case StepperViewStepState.complete:
        return Text(
          '${index + 1}',
          style: isDarkActive ? _kStepStyle.copyWith(color: Colors.black) : _kStepStyle,
        );
      case StepperViewStepState.error:
        return const Text('!', style: _kStepStyle);
    }
  }

  Color _circleColor(int index) {
      return widget.steps[index].state==StepperViewStepState.complete ? Colors.green : Colors.white;
  }

  Widget _buildCircle(int index, bool oldState) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      width: _kStepSize,
      height: _kStepSize,
      child: AnimatedContainer(
        curve: Curves.fastOutSlowIn,
        duration: kThemeAnimationDuration,
        decoration: BoxDecoration(
            color: _circleColor(index),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.black)
        ),
        child: Center(
          child: _buildCircleChild(index, oldState && widget.steps[index].state == StepperViewStepState.error),
        ),
      ),
    );
  }


  Widget? _buildIcon(int index) {
    if (widget.steps[index].state != _oldStates[index]) {
      return AnimatedCrossFade(
        firstChild: _buildCircle(index, true),
        secondChild: const Text('Error'),
        firstCurve: const Interval(0.0, 0.6, curve: Curves.fastOutSlowIn),
        secondCurve: const Interval(0.4, 1.0, curve: Curves.fastOutSlowIn),
        sizeCurve: Curves.fastOutSlowIn,
        crossFadeState: widget.steps[index].state == StepperViewStepState.error ? CrossFadeState.showSecond : CrossFadeState.showFirst,
        duration: kThemeAnimationDuration,
      );
    } else {
      if (widget.steps[index].state != StepperViewStepState.error)
        return _buildCircle(index, false);
    }
  }


  Widget _buildHorizontal() {
    final List<Widget> children = <Widget>[
      for (int i = 0; i < widget.steps.length; i += 1) ...<Widget>[
        InkResponse(
          onTap: () {
            if (widget.onStepTapped != null)
              widget.onStepTapped(i);
          } ,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Row(
              children: <Widget>[
                Container(
                  height: 72.0,
                  child: Center(
                    child: _buildIcon(i),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (!_isLast(i))
          Expanded(
            child: Container(
              color: Colors.black,
              child: SizedBox(
                height: 2.0,
              ),
            ),
          ),
      ],
    ];

    return Column(
      children: <Widget>[
        Material(
          elevation: 0.0,
          child: Container(
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Row(
                children: children,
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
        return _buildHorizontal();
    }
}
