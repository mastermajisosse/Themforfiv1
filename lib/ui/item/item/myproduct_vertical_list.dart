import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/constant/ps_constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterbuyandsell/constant/ps_dimens.dart';
import 'package:flutterbuyandsell/ui/common/ps_hero.dart';
import 'package:flutterbuyandsell/ui/common/ps_ui_widget.dart';
import 'package:flutterbuyandsell/utils/utils.dart';
import 'package:flutterbuyandsell/viewobject/product.dart';

class MyproductVertical extends StatelessWidget {
  const MyproductVertical({
    Key key,
    @required this.product,
    @required this.coreTagKey,
    this.onTap,
  }) : super(key: key);

  final Product product;
  final Function onTap;
  final String coreTagKey;

  @override
  Widget build(BuildContext context) {
    // print('***Tag*** $coreTagKey${PsConst.HERO_TAG__IMAGE}');

    return product.isSoldOut == '1'
        ? Container(
            margin: const EdgeInsets.symmetric(
                horizontal: PsDimens.space4, vertical: PsDimens.space12),
          )
        : InkWell(
            onTap: onTap,
            child: Card(
              elevation: 0.0,
              color: PsColors.transparent,
              child: Container(
                margin: const EdgeInsets.symmetric(
                    horizontal: PsDimens.space4, vertical: PsDimens.space12),
                decoration: BoxDecoration(
                  color: PsColors.backgroundColor,
                  borderRadius:
                      const BorderRadius.all(Radius.circular(PsDimens.space8)),
                ),
                width: PsDimens.space180,
                child: Stack(
                  children: <Widget>[
                    Column(
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(
                            left: PsDimens.space4,
                            top: PsDimens.space4,
                            right: PsDimens.space12,
                            bottom: PsDimens.space4,
                          ),
                          child: Row(
                            children: <Widget>[
                              PsNetworkCircleImageForUser(
                                photoKey: '',
                                imagePath: product.user.userProfilePhoto,
                                width: PsDimens.space40,
                                height: PsDimens.space40,
                                boxfit: BoxFit.cover,
                                onTap: () {
                                  Utils.psPrint(
                                      product.defaultPhoto.imgParentId);
                                  onTap();
                                },
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: PsDimens.space8,
                                      bottom: PsDimens.space8,
                                      top: PsDimens.space8),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
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
                                ),
                              )
                            ],
                          ),
                        ),
                        Expanded(
                          child: Stack(
                            children: <Widget>[
                              PsNetworkImage(
                                photoKey:
                                    '$coreTagKey${PsConst.HERO_TAG__IMAGE}',
                                defaultPhoto: product.defaultPhoto,
                                width: PsDimens.space180,
                                height: double.infinity,
                                boxfit: BoxFit.cover,
                                onTap: () {
                                  Utils.psPrint(
                                      product.defaultPhoto.imgParentId);
                                  onTap();
                                },
                              ),
                              Positioned(
                                  bottom: 0,
                                  child: product.isSoldOut == '1'
                                      ? Container(
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: PsDimens.space12),
                                            child: Align(
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                  Utils.getString(context,
                                                      'dashboard__sold_out'),
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .copyWith(
                                                          color:
                                                              PsColors.white)),
                                            ),
                                          ),
                                          height: 30,
                                          width: PsDimens.space180,
                                          decoration: BoxDecoration(
                                              color: PsColors.soldOutUIColor),
                                        )
                                      : Container()
                                  //   )
                                  // ],
                                  ),
                            ],
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.only(
                              left: PsDimens.space8,
                              top: PsDimens.space12,
                              right: PsDimens.space8),
                          child: Row(
                            children: <Widget>[
                              PsHero(
                                tag: '$coreTagKey$PsConst.HERO_TAG__UNIT_PRICE',
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
                                          .copyWith(color: PsColors.mainColor)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // Padd
                        Padding(
                          padding: const EdgeInsets.only(
                              left: PsDimens.space8,
                              right: PsDimens.space8,
                              top: PsDimens.space8,
                              bottom: PsDimens.space16),
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
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption),
                                  )
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
  }
}
