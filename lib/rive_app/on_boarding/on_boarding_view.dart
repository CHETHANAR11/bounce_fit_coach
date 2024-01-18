import 'dart:ui';
import 'package:bounce_fit_coach/rive_app/on_boarding/sign_in.dart';
import 'package:bounce_fit_coach/rive_app/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';
import 'package:rive/rive.dart';

class OnBoardingView extends StatefulWidget {
  const OnBoardingView({Key? key, this.closeModal}) : super(key: key);

  final Function? closeModal;

  @override
  State<OnBoardingView> createState() => _OnBoardingViewState();
}

class _OnBoardingViewState extends State<OnBoardingView>
    with TickerProviderStateMixin {
  AnimationController? _signInAnimController;

  late RiveAnimationController _btnController;

  @override
  void initState() {
    super.initState();
    _signInAnimController = AnimationController(
        duration: const Duration(milliseconds: 350),
        upperBound: 1,
        vsync: this);

    _btnController = OneShotAnimation("active", autoplay: false);

    const springDesc = SpringDescription(
      mass: 0.1,
      stiffness: 40,
      damping: 5,
    );

    _btnController.isActiveChanged.addListener(() {
      if (!_btnController.isActive) {
        final springAnim = SpringSimulation(springDesc, 0, 1, 0);
        _signInAnimController?.animateWith(springAnim);
      }
    });
  }

  @override
  void dispose() {
    _signInAnimController?.dispose();
    _btnController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        ImageFiltered(
          imageFilter: ImageFilter.blur(sigmaX: 50, sigmaY: 50),
          child: Center(
            child: OverflowBox(
              maxWidth: double.infinity,
              child: Transform.translate(
                offset: const Offset(200, 100),
                child:
                    Image.asset("assets/images/spline.png", fit: BoxFit.cover),
              ),
            ),
          ),
        ),
        AnimatedBuilder(
          animation: _signInAnimController!,
          builder: (context, child) {
            return Transform(
                transform: Matrix4.translationValues(
                    0, -50 * _signInAnimController!.value, 0),
                child: child);
          },
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 260,
                            padding: const EdgeInsets.only(bottom: 16),
                            child: const Text(
                              "Unlock your Potentia",
                              style: TextStyle(
                                  fontFamily: "Poppins", fontSize: 50),
                            ),
                          ),
                          Text(
                            "Elevate your skills and game IQ through this. Your journey to sports mastery starts here.",
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.7),
                                fontFamily: "Inter",
                                fontSize: 17),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  GestureDetector(
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Container(
                        width: 236,
                        height: 64,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.3),
                              blurRadius: 10,
                              offset: const Offset(0, 10),
                            )
                          ],
                        ),
                        child: Stack(
                          children: [
                            RiveAnimation.asset(
                              'assets/rive/button.riv',
                              fit: BoxFit.cover,
                              controllers: [_btnController],
                            ),
                            Center(
                              child: Transform.translate(
                                offset: const Offset(4, 4),
                                child: const Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.arrow_forward_rounded),
                                    SizedBox(width: 4),
                                    Text(
                                      "Start Training",
                                      style: TextStyle(
                                          fontSize: 16,
                                          fontFamily: "Inter",
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      _btnController.isActive = true;
                    },
                  ),
                  // const SizedBox(height: 16),
                  // Text(
                  //   "Purchase includes access to 30+ courses, 240+ premium tutorials, 120+ hours of videos, source files and certificates.",
                  //   style: TextStyle(
                  //       color: Colors.black.withOpacity(0.7),
                  //       fontFamily: "Inter",
                  //       fontSize: 13),
                  // ),
                ],
              ),
            ),
          ),
        ),
        RepaintBoundary(
          child: AnimatedBuilder(
            animation: _signInAnimController!,
            builder: (context, child) {
              return Stack(
                children: [
                  Positioned(
                      top: 100 - (_signInAnimController!.value * 200),
                      right: 20,
                      child: SafeArea(
                        child: CupertinoButton(
                          alignment: Alignment.topRight,
                          padding: EdgeInsets.zero,
                          borderRadius: BorderRadius.circular(36 / 2),
                          minSize: 36,
                          child: Container(
                            width: 36,
                            height: 36,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(36 / 2),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.3),
                                    blurRadius: 10,
                                    offset: const Offset(0, 10))
                              ],
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                            ),
                          ),
                          onPressed: () {
                            widget.closeModal!();
                          },
                        ),
                      )),
                  Positioned.fill(
                    child: IgnorePointer(
                      ignoring: true,
                      child: Opacity(
                        opacity: 0.4 * _signInAnimController!.value,
                        child: Container(color: RiveAppTheme.shadow),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: Offset(
                      0,
                      -MediaQuery.of(context).size.height *
                          (1 - _signInAnimController!.value),
                    ),
                    child: child,
                  ),
                ],
              );
            },
            child: SignIn(
              closeModal: () {
                _signInAnimController?.reverse();
              },
            ),
          ),
        ),
      ]),
    );
  }
}
