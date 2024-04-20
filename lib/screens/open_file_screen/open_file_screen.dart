import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:qr_code_project/data/models/product_model.dart';
import 'package:qr_code_project/screens/qr_scanner_screen/qr_scanner_screen.dart';
import 'package:qr_code_project/services/widget_saver.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/app_img/app_img.dart';
import '../../utils/size/size_screen_all.dart';

class OpenFileProductScreen extends StatefulWidget {
  const OpenFileProductScreen({super.key, required this.productModel});

  final ProductModel productModel;

  @override
  State<OpenFileProductScreen> createState() => _OpenFileProductScreenState();
}

class _OpenFileProductScreenState extends State<OpenFileProductScreen> {
  final GlobalKey _globalKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.c_333333,
      appBar: AppBar(
        backgroundColor: AppColors.c_333333,
        automaticallyImplyLeading: false,
        actions: [
          Container(
            width: width,
            padding: EdgeInsets.symmetric(horizontal: 46.w),
            child: Row(
              children: [
                ZoomTapAnimation(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: AppColors.black.withOpacity(.11),
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_back_ios_new_outlined,
                        color: AppColors.c_FDB623,
                      ),
                    ),
                  ),
                ),
                25.getW(),
                Text(
                  "Result",
                  style: TextStyle(
                    fontSize: 27.w,
                    color: AppColors.cd9,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          20.getH(),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 46.w),
            padding: EdgeInsets.symmetric(horizontal: 23.w),
            decoration: BoxDecoration(
              color: const Color(0xFF3C3C3C),
              borderRadius: BorderRadius.circular(10.w),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  color: Colors.black.withOpacity(.25),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                16.getH(),
                Row(
                  children: [
                    SvgPicture.asset(
                      AppImg.qrCode,
                      width: 50.w,
                      color: AppColors.c_FDB623,
                    ),
                    15.getW(),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productModel.description,
                          style: TextStyle(
                            fontSize: 22.w,
                            color: AppColors.cd9,
                          ),
                        ),
                        6.getH(),
                        Text(
                          widget.productModel.dateTime.substring(0, 16),
                          style: TextStyle(
                            fontSize: 22.w,
                            color: const Color(0xff858585),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                20.getH(),
                Container(
                  width: width,
                  height: 2.h,
                  color: const Color(0xFF858585),
                ),
                20.getH(),
                Text(
                  widget.productModel.qrCode,
                  style: TextStyle(
                    fontSize: 17.w,
                    color: AppColors.cd9,
                  ),
                ),
                Center(
                  child: TextButton(
                    onPressed: () async{
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (context) => InfoScreen(
                      //       productModel: widget.productModel,
                      //     ),
                      //   ),
                      // );
                      Uri uri = Uri.parse(widget.productModel.qrCode);
                      await launchUrl(uri);
                    },
                    child: Text(
                      "Show Qr Code",
                      style: TextStyle(
                        fontSize: 15.w,
                        color: AppColors.c_FDB623,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          42.getH(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ZoomTapAnimation(
                    onTap: () {
                      WidgetSaverService.openWidgetAsImage(
                        context: context,
                        widgetKey: _globalKey,
                        fileId: widget.productModel.id.toString(),
                      );
                    },
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: AppColors.c_FDB623,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: const Icon(Icons.share, color: Colors.black),
                    ),
                  ),
                  7.getH(),
                  Text(
                    "Share",
                    style: TextStyle(
                      fontSize: 15.w,
                      color: AppColors.cd9,
                    ),
                  ),
                ],
              ),
              43.getW(),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ZoomTapAnimation(
                    onTap: () {
                      // WidgetSaverService.saveWidgetToGallery(
                      //   context: context,
                      //   widgetKey: _globalKey,
                      //   fileId: widget.productModel.id.toString(),
                      // );

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => InfoScreen(
                            productModel: widget.productModel,
                          ),
                        ),
                      );
                    },
                    child: Container(
                      height: 60.h,
                      width: 60.w,
                      decoration: BoxDecoration(
                        color: AppColors.c_FDB623,
                        borderRadius: BorderRadius.circular(10.w),
                      ),
                      child: const Icon(Icons.copy, color: Colors.black),
                    ),
                  ),
                  7.getH(),
                  Text(
                    "Copy",
                    style: TextStyle(
                      fontSize: 15.w,
                      color: AppColors.cd9,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
