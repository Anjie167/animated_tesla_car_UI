import 'package:atc/Screens/Components/temp_btn.dart';
import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../home_controller.dart';

class TempDetails extends StatelessWidget {
  const TempDetails({
    Key key,
    @required HomeController controller,
  }) : _controller = controller, super(key: key);

  final HomeController _controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(defaultPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            child: Row(
              children: [
                TempBtn(
                  isActive: _controller.isCoolSelected,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'Cool',
                  press: _controller.updateCoolSelectedTab,
                ),
                const SizedBox(width: defaultPadding,),
                TempBtn(
                  isActive: !_controller.isCoolSelected,
                  svgSrc: 'assets/icons/coolShape.svg',
                  title: 'Heat ',
                  press: _controller.updateCoolSelectedTab,
                  activeColour: redColor,
                ),
              ],
            ),
          ),
          Spacer(),
          Column(
            children: [
              IconButton(
                onPressed: (){},
                icon: Padding(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.arrow_drop_up, size: 48,),
                ),
              ),
              Text(
                '29' + "\u2103", style: TextStyle(
                  fontSize: 86
              ),
              ),
              IconButton(
                onPressed: (){},
                icon: Padding(
                  padding: EdgeInsets.zero,
                  child: Icon(Icons.arrow_drop_down, size: 48,),
                ),
              ),
            ],
          ),

          Spacer(),
          Text('CURRENT TEMPERATURE'),
          const SizedBox(height: defaultPadding,),
          Row(
            children: [
              Column(
                children: [
                  Text('Inside'.toUpperCase(), style: TextStyle(color: Colors.white54),),
                  Text('20' + "\u2103", style: Theme.of(context).textTheme.headline5,
                  )
                ],
              ),
              const SizedBox(width: defaultPadding,),
              Column(
                children: [
                  Text('Inside'.toUpperCase()),
                  Text('35' + "\u2103", style: Theme.of(context).textTheme.headline5.copyWith(color: Colors.white54),
                  )
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
