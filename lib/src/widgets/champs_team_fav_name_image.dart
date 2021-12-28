import 'package:cached_network_image/cached_network_image.dart';
import 'package:champs2022rank1ng/src/configs/z_champs_configs.dart';
import 'package:champs2022rank1ng/src/controllers/champs_teams_favorite_controller.dart';
import 'package:champs2022rank1ng/src/controllers/z_champs_controllers.dart';
import 'package:champs2022rank1ng/src/models/champs_game_odd.dart';
import 'package:champs2022rank1ng/src/models/champs_pregame_model.dart';
import 'package:champs2022rank1ng/src/models/champs_top_teams.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

class TeamFavNameOddImage extends StatefulWidget {
  const TeamFavNameOddImage(
      {Key? key,
      required this.team,
      required this.game,
      required this.onPressed})
      : super(key: key);

  final Function() onPressed;
  final Team team;
  final UpComingGame game;

  @override
  State<TeamFavNameOddImage> createState() => _TeamFavNameOddImageState();
}

class _TeamFavNameOddImageState extends State<TeamFavNameOddImage> {
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
    final _favResposne = await favoriteController.isFavorite(widget.team.id);
    setState(() {
      _isFavorite = _favResposne;
    });
  }

  late FavoriteContorller favoriteController;
  late TopTeam _topTeam;
  @override
  Widget build(BuildContext context) {
    favoriteController =
        Provider.of<FavoriteContorller>(context, listen: false);
    final matchModel = Provider.of<UpcomingMatchModel>(context, listen: false);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: FutureBuilder<GameOdd>(
          future: matchModel.getOdd(widget.game.gameId),
          builder: (context, snapshots) {
            if (snapshots.hasData) {
              _topTeam = TopTeam(
                  name: widget.team.name,
                  flag: widget.team.id,
                  odd: double.parse(widget.game.home.name == widget.team.name
                      ? snapshots.data!.homeOd
                      : snapshots.data!.awayOd));
            }
            return Container(
              padding:
                  const EdgeInsets.only(right: 20.0, top: 15.0, bottom: 15.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        padding: const EdgeInsets.all(0.0),
                        onPressed: () async {
                          if (_isFavorite) {
                            favoriteController.deleteTeam(widget.team.id);
                          } else {
                            if (snapshots.hasData) {
                              favoriteController.insertTeam(_topTeam);
                            }
                          }
                          setState(() {
                            _isFavorite = !_isFavorite;
                          });
                        },
                        icon: Icon(
                          Icons.star,
                          size: 32.0,
                          color: _isFavorite ? Colors.amber : greyColor,
                        ),
                      ),
                      CachedNetworkImage(
                        imageUrl:
                            'https://spoyer.ru/api/team_img/soccer/${widget.team.id}.png',
                        imageBuilder: (context, imageProvider) => Container(
                          width: 35.0,
                          height: 35.0,
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
                            fontSize: 17.0,
                            fontFamily: "Open Sans"),
                      )
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 20.0),
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 10.0),
                    decoration: BoxDecoration(
                        color: lightGreen,
                        borderRadius: BorderRadius.circular(12.0)),
                    child: snapshots.hasData
                        ? Text(
                            widget.game.home.name == widget.team.name
                                ? snapshots.data!.homeOd
                                : snapshots.data!.awayOd,
                            style: const TextStyle(
                              color: greyFourth,
                              fontWeight: FontWeight.w700,
                              fontSize: 17.0,
                            ))
                        : const SpinKitThreeBounce(
                            color: primaryColor,
                            size: 20.0,
                          ),
                  ),
                ],
              ),
            );
          }),
    );
  }
}
