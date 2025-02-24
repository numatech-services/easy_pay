import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:viserpay/core/utils/dimensions.dart';
import 'package:viserpay/core/utils/my_color.dart';
import 'package:viserpay/view/components/shimmer/shimmer_widget.dart';

class FaqCardShimmer extends StatelessWidget {
  const FaqCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: BoxDecoration(color: MyColor.colorWhite, borderRadius: BorderRadius.circular(Dimensions.mediumRadius)),
      width: context.width,
      padding: const EdgeInsets.symmetric(horizontal: Dimensions.space15, vertical: Dimensions.space15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyShimmerWidget(
                child: Container(
                  width: context.width / 3,
                  height: 8,
                  decoration: BoxDecoration(
                    color: MyColor.colorGrey2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space5),
              MyShimmerWidget(
                child: Container(
                  width: context.width / 3 - 20,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MyColor.colorGrey2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: Dimensions.space5),
              MyShimmerWidget(
                child: Container(
                  width: context.width / 4 - 20,
                  height: 4,
                  decoration: BoxDecoration(
                    color: MyColor.colorGrey2,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
            ],
          ),
          MyShimmerWidget(
            child: Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(color: MyColor.colorGrey2, shape: BoxShape.circle),
            ),
          ),
        ],
      ),
    );
  }
}
