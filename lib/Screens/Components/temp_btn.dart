import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants.dart';

class TempBtn extends StatelessWidget {
  const TempBtn({
    Key key, this.svgSrc, this.isActive = false, this.press, this.title, this.activeColour,
  }) : super(key: key);

  final String svgSrc, title;
  final bool isActive;
  final Function press;
  final Color activeColour;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          AnimatedContainer(
            curve: Curves.easeInOutBack,
            duration: Duration(milliseconds: 200),
            height: isActive ? 76 : 50 ,
            width: isActive ? 76 : 50 ,
            child: SvgPicture.asset(svgSrc, color: isActive ? activeColour : Colors.white38,),),
          const SizedBox(height: defaultPadding/2,),
          AnimatedDefaultTextStyle(
            style: TextStyle(
                fontSize: 16,
                color:  isActive ? activeColour : Colors.white38,
                fontWeight: isActive ? FontWeight.bold : FontWeight.normal),
            duration: Duration(milliseconds: 200),
            child: Text(title.toUpperCase(),
              // style: TextStyle(
              //   fontSize: 16,
              //   color:  isActive ? primaryColor : Colors.white38,
              //   fontWeight: isActive ? FontWeight.bold : FontWeight.normal),),
            ),
          ),],
      ),
    );
  }
}
