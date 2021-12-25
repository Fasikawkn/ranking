import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:flutter/material.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({required this.onTap, Key? key}) : super(key: key);
  final Function(String country) onTap;

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final List<String> _countries = [
    'Country',
    'England',
    'Spain',
    'Italy',
    'Japan',
    'Russia',
    'Ukraine',
    'Portugal',
    'Germany',
    'England1',
    'Spain1',
    'Italy1',
    'Japan1',
    'Russia1',
    'Ukraine1',
    'Portugal1',
    'Germany1',
  ];

  String _indexValue = "Country";

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
              children: _countries
                  .map((country) => CountriesItem(
                        name: country,
                        value: country,
                        color:
                            _indexValue == country ? primaryColor : greySecond,
                        onTap: (value) {
                          setState(() {
                            _indexValue = value;
                          });
                          widget.onTap(value);
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
