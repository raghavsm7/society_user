import 'package:fl_sevengen_society_user_app/constants/text_style_constant.dart';
import 'package:fl_sevengen_society_user_app/utils/app_utils.dart';
import 'package:flutter/material.dart';
import '../constants/color.dart';
import '../constants/dimens.dart';
import 'common_widgets.dart';

class ClickToRetryWidget extends StatefulWidget {
  bool visible;
  Function callback;
  double size;
  Color color;

  ClickToRetryWidget({super.key, 
    required this.visible,
    required this.callback,
    this.size = size_14,
    this.color = colorBackground,
  });

  @override
  _ClickToRetryWidgetState createState() => _ClickToRetryWidgetState();
}

class _ClickToRetryWidgetState extends State<ClickToRetryWidget> with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.elasticOut,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
      child: Center(
        child: Visibility(
          visible: !widget.visible,
          replacement: const SizedBox(),
          child: InkWell(
            onTap: () {
              widget.callback();
            },
            child: SizedBox(
              height: AppUtils.appUtilsInstance
                  .getPercentageSize(ofWidth: false, percentage: ((widget.size) * 3)),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RotationTransition(
                      turns: _animation,
                      child: Container()/*SvgPicture.asset(
                        Icons.refresh,
                        height: AppUtils.appUtilsInstance.getPercentageSize(percentage: widget.size),
                        width: AppUtils.appUtilsInstance.getPercentageSize(percentage: widget.size),
                      )*/,
                    ),
                    spacing(),
                    textWidget(/*AppLocalizations.of(Get.context!).common.text.clickToRetryText*/"Click to retry",
                        style: textCustom(
                            color: colorPrimary, size: size_20, textStyleEnum: TextStyleEnum.semiBold),
                        textAlign: TextAlign.center),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
