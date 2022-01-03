import 'package:atc/constants.dart';
import 'package:atc/home_controller.dart';
import 'package:atc/models/TyrePsi.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'Components/battery_status.dart';
import 'Components/door_lock.dart';
import 'Components/temp_details.dart';
import 'Components/tesla_bottom_navigation.dart';
import 'Components/tyre_psi_card.dart';
import 'Components/tyres.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final HomeController _controller = HomeController();
  AnimationController _batteryAnimationController;
  Animation<double> _animationBattery;
  Animation<double> _animationBatteryStatus;

  AnimationController _tempAnimationController;
  Animation<double> _animationCarShift;
  Animation<double> _animationTempShowInfo;
  Animation<double> _animationCoolGlow;

  AnimationController _tyreAnimationController;
  Animation<double> _animationTyre1Psi;
  Animation<double> _animationTyre2Psi;
  Animation<double> _animationTyre3Psi;
  Animation<double> _animationTyre4Psi;

  List<Animation<double>> _tyreAnimations;

  void setupTempAnimation() {
    _tempAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _animationCarShift = CurvedAnimation(
        parent: _tempAnimationController, curve: Interval(0.2, 0.4));
    _animationTempShowInfo = CurvedAnimation(
        parent: _tempAnimationController, curve: Interval(0.45, 0.65));
    _animationCoolGlow = CurvedAnimation(
        parent: _tempAnimationController, curve: Interval(0.7, 1));
  }

  void setupBatteryAnimation() {
    _batteryAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 600));
    _animationBattery = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.0, 0.5),
    );
    _animationBatteryStatus = CurvedAnimation(
      parent: _batteryAnimationController,
      curve: Interval(0.6, 1),
    );
  }

  void setupTyreAnimation() {
    _tyreAnimationController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1200));
    //1200 * 0.34 = 400 ....we want to delay it by 400 so the car animates from the right side
    _animationTyre1Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.34, 0.5));
    _animationTyre2Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.5, 0.66));
    _animationTyre3Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.66, 0.82));
    _animationTyre4Psi = CurvedAnimation(
        parent: _tyreAnimationController, curve: Interval(0.82, 1));
  }

  @override
  void initState() {
    setupBatteryAnimation();
    setupTempAnimation();
    setupTyreAnimation();
    _tyreAnimations = [
      _animationTyre1Psi,
      _animationTyre2Psi,
      _animationTyre3Psi,
      _animationTyre4Psi
    ];
    super.initState();
  }

  @override
  void dispose() {
    _batteryAnimationController.dispose();
    _tempAnimationController.dispose();
    _tyreAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        //this animation needs listenable
        animation: Listenable.merge([
          _controller,
          _batteryAnimationController,
          _tempAnimationController,
          _tyreAnimationController
        ]),
        builder: (context, _) {
          return Scaffold(
            bottomNavigationBar: TeslaBottomNavigator(
              onTap: (index) {
                if (index == 1) {
                  _batteryAnimationController.forward();
                } else if (_controller.selectedBottomTab == 1 && index != 1) {
                  _batteryAnimationController.reverse(from: 0.7);
                }
                if (index == 2) {
                  _tempAnimationController.forward();
                } else if (_controller.selectedBottomTab == 2 && index != 2) {
                  _tempAnimationController.reverse(from: 0.4);
                }

                if (index == 3) {
                  _tyreAnimationController.forward();
                } else if (_controller.selectedBottomTab == 3 && index != 3) {
                  _tyreAnimationController.reverse(from: 1);
                }
                _controller.showTyreController(index);
                _controller.tyreStatusController(index);
                _controller.onBottomNavigationTabChange(index);
              },
              selectedTab: _controller.selectedBottomTab,
            ),
            body: SafeArea(
              child: LayoutBuilder(builder: (context, constrains) {
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                    ),
                    Positioned(
                      left: constrains.maxWidth / 2 * _animationCarShift.value,
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: constrains.maxHeight * 0.1),
                        child: SvgPicture.asset(
                          'assets/icons/Car.svg',
                          width: double.infinity,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      right: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isRightDoorLock,
                          press: _controller.updateRightDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      left: _controller.selectedBottomTab == 0
                          ? constrains.maxWidth * 0.05
                          : constrains.maxWidth / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isLeftDoorLock,
                          press: _controller.updateLeftDoorLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      top: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.05
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isTrunkLock,
                          press: _controller.updateTrunkLock,
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      duration: defaultDuration,
                      bottom: _controller.selectedBottomTab == 0
                          ? constrains.maxHeight * 0.05
                          : constrains.maxHeight / 2,
                      child: AnimatedOpacity(
                        duration: defaultDuration,
                        opacity: _controller.selectedBottomTab == 0 ? 1 : 0,
                        child: DoorLock(
                          isLock: _controller.isBonnetLock,
                          press: _controller.updateBonnetLock,
                        ),
                      ),
                    ),

                    //battery
                    Opacity(
                        opacity: _animationBattery.value,
                        child: SvgPicture.asset(
                          'assets/icons/Battery.svg',
                          width: constrains.maxWidth * 0.45,
                        )),
                    Positioned(
                      top: 50 * (1 - _animationBatteryStatus.value),
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      child: Opacity(
                          opacity: _animationBatteryStatus.value,
                          child: BatteryStatus(
                            constrains: constrains,
                          )),
                    ),
                    //Temp
                    Positioned(
                      height: constrains.maxHeight,
                      width: constrains.maxWidth,
                      top: 60 * (1 - _animationTempShowInfo.value),
                      child: Opacity(
                        opacity: _animationTempShowInfo.value,
                        child: TempDetails(controller: _controller),
                      ),
                    ),
                    Positioned(
                      right: -180 * (1 - _animationCoolGlow.value),
                      child: AnimatedSwitcher(
                        duration: defaultDuration,
                        child: _controller.isCoolSelected
                            ? Image.asset(
                                'assets/images/Cool_glow_2.png',
                                key: UniqueKey(),
                                width: 200,
                              )
                            : Image.asset(
                                'assets/images/Hot_glow_4.png',
                                key: UniqueKey(),
                                width: 200,
                              ),
                      ),
                    ),
                    //Tyre
                    if (_controller.isShowTyres) ...tyres(constrains),
                    if (_controller.isShowTyreStatus)
                      GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: 4,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: defaultPadding,
                            crossAxisSpacing: defaultPadding,
                            childAspectRatio:
                                constrains.maxWidth / constrains.maxHeight),
                        itemBuilder: (context, index) => ScaleTransition(
                          scale: _tyreAnimations[index],
                          child: TyrePsiCard(
                            tyrePsi: demoPsiList[index],
                            isBottomTwoTyre: index > 1,
                          ),
                        ),
                      )
                  ],
                );
              }),
            ),
          );
        });
  }
}
