import 'package:fl_sevengen_society_user_app/localization/localization_const.dart';
import 'package:fl_sevengen_society_user_app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_swipe_button/flutter_swipe_button.dart';

class CallingScreen extends StatefulWidget {
  const CallingScreen({super.key});

  @override
  State<CallingScreen> createState() => _CallingScreenState();
}

class _CallingScreenState extends State<CallingScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFFE9F6FF),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: EdgeInsets.zero,
        children: [
          SizedBox(
            height: size.height,
            width: size.width,
            child: Padding(
              padding: const EdgeInsets.all(fixPadding * 2.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  callerDetail(size),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      callOptionWidget(Icons.call_outlined, primaryColor,
                          getTranslate(context, 'calling.call_gate')),
                      pickupCallButton(size, context),
                      callOptionWidget(Icons.close, lightRedColor,
                          getTranslate(context, 'calling.deny'))
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  pickupCallButton(Size size, BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Transform.rotate(
            angle: 4.7,
            child: SwipeButton.expand(
              activeThumbColor: green3EColor,
              activeTrackColor: whiteColor,
              borderRadius: BorderRadius.circular(40.0),
              duration: const Duration(seconds: 2),
              height: 50,
              width: double.maxFinite,
              thumbPadding: const EdgeInsets.all(fixPadding / 2),
              elevationTrack: 2.0,
              elevationThumb: 1.0,
              thumb: const Icon(
                Icons.arrow_forward,
                size: 24,
                color: whiteColor,
              ),
              onSwipeEnd: () {
                Navigator.pop(context);
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor,
                    size: 28,
                  ),
                  heightSpace,
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor.withOpacity(0.6),
                    size: 28,
                  ),
                  heightSpace,
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor.withOpacity(0.4),
                    size: 28,
                  ),
                  heightSpace,
                  Icon(
                    Icons.keyboard_arrow_right,
                    color: primaryColor.withOpacity(0.1),
                    size: 28,
                  ),
                  heightSpace,
                ],
              ),
            ),
          ),
          heightBox(size.height * 0.14),
          Text(
            getTranslate(context, 'calling.swipe_up'),
            style: medium16Black33,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    );
  }

  callOptionWidget(IconData icon, Color color, String title) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 68.0),
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Column(
          children: [
            Container(
              height: 45.0,
              width: 45.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
              alignment: Alignment.center,
              child: Icon(
                icon,
                color: whiteColor,
              ),
            ),
            heightSpace,
            Text(
              title,
              style: medium16Primary,
              overflow: TextOverflow.ellipsis,
            )
          ],
        ),
      ),
    );
  }

  callerDetail(Size size) {
    return Column(
      children: [
        heightSpace,
        heightSpace,
        heightSpace,
        Text(
          "SEVENGEN",
          style:
              semibold15Primary.copyWith(color: primaryColor.withOpacity(0.5)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 10.0,
              height: 2,
              color: primaryColor.withOpacity(0.5),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: fixPadding / 2),
              child: Text(
                "Society",
                style:
                    medium12Grey.copyWith(color: primaryColor.withOpacity(0.5)),
              ),
            ),
            Container(
              width: 10.0,
              height: 2,
              color: primaryColor.withOpacity(0.5),
            ),
          ],
        ),
        heightSpace,
        heightSpace,
        height5Space,
        Container(
          height: size.height * 0.18,
          width: size.height * 0.18,
          decoration: const BoxDecoration(
            color: whiteColor,
            shape: BoxShape.circle,
            image: DecorationImage(
              image: AssetImage(
                "assets/call/image2.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
        ),
        heightSpace,
        heightSpace,
        const Text(
          "Cameron Williamson",
          style: semibold20Primary,
          textAlign: TextAlign.center,
        ),
        height5Space,
        Text(
          getTranslate(context, 'calling.guest_waiting_gate'),
          style: medium16Grey,
          textAlign: TextAlign.center,
        )
      ],
    );
  }
}
