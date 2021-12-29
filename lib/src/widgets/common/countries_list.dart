import 'package:champs2022rank1ng/src/configs/countries.dart';
import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  String _indexValue = "kco";

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Dialog(
      insetPadding: const EdgeInsets.only(top: 27, right: 30),
      child: Container(
        width: size.width,
        height: 400,
        color: greySecond,
        child: RawScrollbar(
          isAlwaysShown: true,
          thumbColor: greyFirst,
          thickness: 15.0,
          child: SingleChildScrollView(
            child: Column(
              children: countries.entries
                  .map((country) => CountriesItem(
                        name: country.key,
                        value: country.value,
                        color: _indexValue == country.value
                            ? primaryColor
                            : greySecond,
                        onTap: (value) async {
                          setState(() {
                            _indexValue = value;
                          });
                          Future.delayed(const Duration(milliseconds: 100));
                       
                          Navigator.of(context).pop(value);
                        },
                      ))
                  .toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class CountriesItem extends StatelessWidget {
  const CountriesItem({
    Key? key,
    required this.name,
    required this.value,
    required this.onTap,
    required this.color,
  }) : super(key: key);

  final String name;
  final String value;
  final Color color;
  final Function(String value) onTap;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () {
        onTap(value);
      },
      child: Container(
        key: Key(value),
        width: size.width,
        color: color,
        padding: const EdgeInsets.symmetric(
          vertical: 15.0,
          horizontal: 20.0,
        ),
        child: Text(
          name,
          style: kAppbarTextStyle,
        ),
      ),
    );
  }
}
