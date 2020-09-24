import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/constant/ps_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbuyandsell/constant/ps_dimens.dart';
import 'package:flutterbuyandsell/ui/common/ps_hero.dart';
import 'package:flutterbuyandsell/ui/common/ps_ui_widget.dart';
import 'package:flutterbuyandsell/utils/utils.dart';
import 'package:flutterbuyandsell/viewobject/product.dart';

class Mysproo extends StatelessWidget {
  const Mysproo(
      {Key key,
      @required this.product,
      this.onTap,
      this.animationController,
      this.animation,
      this.coreTagKey})
      : super(key: key);

  final Product product;
  final Function onTap;
  final AnimationController animationController;
  final Animation<double> animation;
  final String coreTagKey;

  @override
  Widget build(BuildContext context) {
    //print("${PsConfig.ps_app_image_thumbs_url}${subCategory.defaultPhoto.imgPath}");
    animationController.forward();
    return product.isSoldOut == '1'
        ? Container()
        : AnimatedBuilder(
            animation: animationController,
            child: InkWell(
              onTap: onTap,
              child: GridTile(
                footer: Container(),
                header: Container(
                  child: Ink(
                    color: PsColors.backgroundColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                    ),
                  ),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.all(
                        Radius.circular(PsDimens.space8)),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.end,
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(
                          left: PsDimens.space4,
                          top: PsDimens.space4,
                          // right: PsDimens.space12,
                          bottom: PsDimens.space4,
                        ),
                        child: Row(
                          children: <Widget>[
                            PsNetworkCircleImageForUser(
                              photoKey: '',
                              imagePath: product.user.userProfilePhoto,
                              width: PsDimens.space28,
                              height: PsDimens.space28,
                              boxfit: BoxFit.cover,
                              onTap: () {
                                Utils.psPrint(product.defaultPhoto.imgParentId);
                                onTap();
                              },
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: PsDimens.space8,
                                  bottom: PsDimens.space8,
                                  top: PsDimens.space8),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                      product.user.userName == ''
                                          ? Utils.getString(
                                              context, 'default__user_name')
                                          : '${product.user.userName}',
                                      textAlign: TextAlign.start,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1),
                                  if (product.paidStatus ==
                                      PsConst.PAID_AD_PROGRESS)
                                    Text(
                                        Utils.getString(
                                            context, 'paid_ad__sponsor'),
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                color: PsColors.mainColor))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      PsNetworkImage(
                        photoKey: '$coreTagKey${PsConst.HERO_TAG__IMAGE}',
                        defaultPhoto: product.defaultPhoto,
                        width: PsDimens.space220,
                        height: PsDimens.space160,
                        boxfit: BoxFit.cover,
                        onTap: () {
                          Utils.psPrint(product.defaultPhoto.imgParentId);
                          onTap();
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            left: PsDimens.space8,
                            right: PsDimens.space8,
                            top: PsDimens.space4),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  width: PsDimens.space8,
                                  height: PsDimens.space8,
                                  decoration: BoxDecoration(
                                      color: PsColors.itemTypeColor,
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(PsDimens.space4))),
                                ),
                                Padding(
                                    padding: const EdgeInsets.only(
                                        left: PsDimens.space8,
                                        right: PsDimens.space4),
                                    child: Text('${product.itemType.name}',
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption))
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                PsHero(
                                  tag:
                                      '$coreTagKey$PsConst.HERO_TAG__UNIT_PRICE',
                                  flightShuttleBuilder:
                                      Utils.flightShuttleBuilder,
                                  child: Material(
                                    type: MaterialType.transparency,
                                    child: Text(
                                        product.price != ''
                                            ? '${product.itemCurrency.currencySymbol}${Utils.getPriceFormat(product.price)}'
                                            : '',
                                        textAlign: TextAlign.start,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle2
                                            .copyWith(
                                                color: PsColors.mainColor)),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: <Widget>[
                                Image.asset(
                                  'assets/images/baseline_favourite_grey_24.png',
                                  width: PsDimens.space10,
                                  height: PsDimens.space10,
                                  fit: BoxFit.contain,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                    left: PsDimens.space4,
                                  ),
                                  child: Text('${product.favouriteCount}',
                                      textAlign: TextAlign.start,
                                      style:
                                          Theme.of(context).textTheme.caption),
                                )
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            builder: (BuildContext context, Widget child) {
              return FadeTransition(
                  opacity: animation,
                  child: Transform(
                      transform: Matrix4.translationValues(
                          0.0, 100 * (1.0 - animation.value), 0.0),
                      child: child));
            });
  }
}
