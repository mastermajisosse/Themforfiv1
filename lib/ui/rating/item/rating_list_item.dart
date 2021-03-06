import 'package:flutterbuyandsell/config/ps_colors.dart';
import 'package:flutterbuyandsell/constant/ps_dimens.dart';
import 'package:flutterbuyandsell/ui/common/smooth_star_rating_widget.dart';
import 'package:flutterbuyandsell/viewobject/rating.dart';
import 'package:flutter/material.dart';

class RatingListItem extends StatelessWidget {
  const RatingListItem({
    Key key,
    @required this.rating,
    this.onTap,
  }) : super(key: key);

  final Rating rating;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        color: PsColors.backgroundColor,
        margin: const EdgeInsets.only(top: PsDimens.space8),
        child: Ink(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              _RatingListDataWidget(
                rating: rating,
              ),
              const Divider(
                height: PsDimens.space1,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RatingListDataWidget extends StatelessWidget {
  const _RatingListDataWidget({
    Key key,
    @required this.rating,
  }) : super(key: key);

  final Rating rating;

  @override
  Widget build(BuildContext context) {
    final Widget _ratingStarsWidget = SmoothStarRating(
        key: Key(rating.rating),
        rating: double.parse(rating.rating),
        allowHalfRating: false,
        isReadOnly: true,
        starCount: 5,
        size: PsDimens.space16,
        color: PsColors.ratingColor,
        borderColor: PsColors.grey.withAlpha(100),
        spacing: 0.0);

    const Widget _spacingWidget = SizedBox(
      height: PsDimens.space8,
    );
    final Widget _titleTextWidget = Text(
      rating.title,
      style: Theme.of(context)
          .textTheme
          .subtitle1
          .copyWith(fontWeight: FontWeight.bold),
    );
    final Widget _descriptionTextWidget = Text(
      rating.description,
      maxLines: 3,
      overflow: TextOverflow.ellipsis,
      style: Theme.of(context).textTheme.bodyText1.copyWith(),
    );
    return Padding(
      padding: const EdgeInsets.all(PsDimens.space12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _ratingStarsWidget,
          _spacingWidget,
          _titleTextWidget,
          _spacingWidget,
          _descriptionTextWidget,
        ],
      ),
    );
  }
}