import 'package:cached_network_image/cached_network_image.dart';
import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/champs_teams_favorite_controller.dart';
import 'package:champs2022rank1ng/src/models/champs_top_teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';


class FavTeamFavNameOddImage extends StatefulWidget {
  const FavTeamFavNameOddImage(
      {Key? key,
      required this.team,
      required this.onPressed,
      this.unFavorite})
      : super(key: key);

  final Function() onPressed;
  final Function()? unFavorite;
  final TopTeam team;

  @override
  State<FavTeamFavNameOddImage> createState() =>
      _FavTeamFavNameOddImageState();
}

class _FavTeamFavNameOddImageState extends State<FavTeamFavNameOddImage> {
  bool _isFavorite = false;
  @override
  void initState() {
    super.initState();
    _getFavorite();
  }

  _getFavorite() async {
    // debugPrint("${widget.team.team!.id}");
    final favoriteController =
        Provider.of<FavoriteContorller>(context, listen: false);
    final _favResposne = await favoriteController.isFavorite(widget.team.flag);
    setState(() {
      _isFavorite = _favResposne;
    });
  }

  _toggleFavorite() {
    setState(() {
      _isFavorite = !_isFavorite;
    });
  }

  late FavoriteContorller favoriteContorller;

  @override
  Widget build(BuildContext context) {
   favoriteContorller =  Provider.of<FavoriteContorller>(context);
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Container(
          padding: const EdgeInsets.only(right: 20.0, top: 15.0, bottom: 15.0),
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(color: greyColor.withOpacity(0.3)))),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    padding: const EdgeInsets.all(0.0),
                    onPressed: () {
                     
                        widget.onPressed();
                      
                    },
                    icon:const Icon(
                            Icons.star,
                            size: 32.0,
                            color: Colors.amber,
                          )
                        
                  ),
                  CachedNetworkImage(
                    imageUrl:
                        'https://spoyer.ru/api/team_img/soccer/${widget.team.flag}.png',
                    imageBuilder: (context, imageProvider) => Container(
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(image: imageProvider)),
                    ),
                    placeholder: (context, url) => const SpinKitThreeBounce(
                      color: primaryColor,
                      size: 20.0,
                    ),
                    errorWidget: (context, url, err) => const CircleAvatar(
                      radius: 20.0,
                      child: Icon(
                        Icons.image,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  Text(
                    widget.team.name,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                        color: greyFourth,
                        fontWeight: FontWeight.w800,
                        fontSize: 15.0,
                        fontFamily: "Open Sans"),
                  )
                ],
              ),
              const SizedBox(
                width: 20.0,
              ),
              Container(
                  padding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 10.0),
                  decoration: BoxDecoration(
                      color: lightGreen,
                      borderRadius: BorderRadius.circular(12.0)),
                  child: Text('${widget.team.odd}',
                      style: const TextStyle(
                        color: greyFourth,
                        fontWeight: FontWeight.w700,
                        fontSize: 17.0,
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}