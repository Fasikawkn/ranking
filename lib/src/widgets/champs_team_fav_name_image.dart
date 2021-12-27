import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';

class TeamFavNameOddImage extends StatelessWidget {
  const TeamFavNameOddImage(
      {Key? key,
      required this.image,
      required this.name,
      required this.odd,
      required this.onPressed})
      : super(key: key);

  final Function() onPressed;
  final String image;
  final String name;
  final String odd;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(right: 20.0, top: 15.0, bottom: 15.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              IconButton(
                padding: const EdgeInsets.all(0.0),
                onPressed: onPressed,
                icon: const Icon(
                  Icons.star,
                  size: 32.0,
                  color: Colors.amber,
                ),
              ),
              Image.asset(
               image,
                width: 40,
              ),
              const SizedBox(
                width: 10.0,
              ),
               Text(
                name,
                style: const TextStyle(
                    color: greyFourth,
                    fontWeight: FontWeight.w800,
                    fontSize: 17.0,
                    fontFamily: "Open Sans"),
              )
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10.0),
            decoration: BoxDecoration(
                color: lightGreen, borderRadius: BorderRadius.circular(12.0)),
            child:  Text(odd,
                style: const TextStyle(
                  color: greyFourth,
                  fontWeight: FontWeight.w700,
                  fontSize: 17.0,
                )),
          )
        ],
      ),
    );
  }
}
