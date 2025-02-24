import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/utils/style.dart';
import 'package:viserpay/core/utils/util.dart';

import '../../../../core/utils/dimensions.dart';
import '../../../../core/utils/my_color.dart';
import '../../../../core/utils/my_strings.dart';

class OperatorWidget extends StatelessWidget {

  final String? title;
  final String? image;
  final bool isShowChangeButton;
  final VoidCallback? onTap;

  const OperatorWidget({
    super.key,
    this.image,
    this.title,
    this.isShowChangeButton = false,
    this.onTap
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: Dimensions.space16,vertical: 13),
        decoration: BoxDecoration(
          // color: MyColor.skyBlue.withOpacity(.7),
          color: MyColor.primaryColor.withOpacity(.2),
          borderRadius: BorderRadius.circular(4),
          boxShadow: MyUtils.getCardShadow()
        ),
        child: Row(
          children: [

            CachedNetworkImage(
              height: 25,
              width: 25,
              fit: BoxFit.cover,
              imageUrl: image ?? "",
              // placeholder: (context, url) => const CustomImageLoader(),
              // errorWidget: (context, url, error) => Image.asset(MyImages.tower,width: 25,height: 25,),
            ),
            const SizedBox(width: 14,),
            Expanded(child: Text(title ?? "".tr,style: regularDefault.copyWith(color:MyColor.colorBlack),maxLines: 1,overflow: TextOverflow.ellipsis,)),

            isShowChangeButton ?
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 6),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: MyColor.primaryColor
              ),
              child: Text(MyStrings.change.tr,style: regularDefault.copyWith(color: MyColor.getTextColor()),),
            ) : const SizedBox.shrink()
          ],
        ),
      ),
    );
  }
}
