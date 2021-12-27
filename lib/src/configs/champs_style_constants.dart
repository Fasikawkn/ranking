import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';

const kAppbarTextStyle = TextStyle(
  color: whiteColor,
  fontFamily: "Open Sans",
  fontSize: 16,
  fontWeight: FontWeight.w800,
);

const kTimeDateTextStyle = TextStyle(
  color: Colors.grey,
  fontFamily: "Open Sans",
);

final kBottomAppBarButtonStyle = TextButton.styleFrom(
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(
      Radius.circular(60.0),
    ),
  ),
);

const kLeagueNameLabelStyle = TextStyle(
  color: whiteColor,
  fontSize: 18.0,
  fontWeight: FontWeight.w400,
  fontFamily: "Open Sans",
);

const kLeagueGameTimeLabelStyle = TextStyle(
  color: whiteColor,
  fontFamily: "Open Sans",
);
