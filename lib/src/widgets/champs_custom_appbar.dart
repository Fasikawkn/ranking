import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomBottomAppBar extends StatefulWidget {
  const CustomBottomAppBar({Key? key, required this.onSelect})
      : super(key: key);

  final Function(int index) onSelect;

  @override
  State<CustomBottomAppBar> createState() => _CustomBottomAppBarState();
}

class _CustomBottomAppBarState extends State<CustomBottomAppBar> {
  int _initalIndex = 0;
  _onPressed(int index) {
    setState(() {
      _initalIndex = index;
    });
    widget.onSelect(index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      color: greyFourth,
      child: Row(
        children: [
          Expanded(
            child: TextButton(
                style: kBottomAppBarButtonStyle,
                onPressed: () {
                  _onPressed(0);
                },
                child: SvgPicture.asset(
                  'assets/images/home.svg',
                  color: _initalIndex == 0 ? primaryColor : whiteColor,
                )),
          ),
          const VerticalDivider(
            color: greyColor,
          ),
          Expanded(
            child: TextButton(
              style: kBottomAppBarButtonStyle,
              onPressed: () {
                _onPressed(1);
              },
              child: Icon(
                Icons.star,
                color: _initalIndex == 1 ? primaryColor : whiteColor,
              ),
            ),
          ),
          const VerticalDivider(
            color: greyColor,
          ),
          Expanded(
            child: TextButton(
                style: kBottomAppBarButtonStyle,
                onPressed: () {
                  _onPressed(2);
                },
                child: SvgPicture.asset('assets/images/top_teams.svg',
                    color: _initalIndex == 2 ? primaryColor : whiteColor)),
          ),
        ],
      ),
    );
  }
}
