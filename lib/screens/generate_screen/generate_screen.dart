import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_project/bloc/products_bloc.dart';
import 'package:qr_code_project/bloc/products_event.dart';
import 'package:qr_code_project/data/models/product_model.dart';
import 'package:qr_code_project/utils/app_img/app_img.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../utils/app_colors/app_colors.dart';
import '../../utils/size/size_screen_all.dart';

class GenerateScreen extends StatefulWidget {
  const GenerateScreen({super.key});

  @override
  State<GenerateScreen> createState() => _GenerateScreenState();
}

class _GenerateScreenState extends State<GenerateScreen> {
  final TextEditingController urlController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.c_333333.withOpacity(.84),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 46.w, vertical: 38.h),
        child: Column(
          children: [
            Text(
              "Generate qrCode",
              style: TextStyle(
                color: AppColors.c_D9D9D9,
                fontSize: 27.w,
                fontWeight: FontWeight.w400,
              ),
            ),
            Expanded(
              child: ListView(
                children: [
                  100.getH(),
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 23.w, vertical: 40.h),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6.w),
                      border: Border.symmetric(
                        horizontal: BorderSide(
                          width: 2.w,
                          color: AppColors.c_FDB623,
                        ),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(child: SvgPicture.asset(AppImg.txt)),
                        20.getH(),
                        Text(
                          "Name",
                          style: TextStyle(
                            color: AppColors.c_D9D9D9,
                            fontSize: 20.w,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        10.getH(),
                        TextField(
                          controller: nameController,
                          style: TextStyle(
                            color: AppColors.c_D9D9D9.withOpacity(.34),
                            fontSize: 16.w,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter name",
                            hintStyle: TextStyle(
                              color: AppColors.c_D9D9D9.withOpacity(.34),
                              fontSize: 16.w,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.w),
                              borderSide: BorderSide(
                                color: AppColors.c_D9D9D9,
                                width: 1.w,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.w),
                              borderSide: BorderSide(
                                color: AppColors.c_D9D9D9,
                                width: 1.w,
                              ),
                            ),
                          ),
                        ),
                        10.getH(),
                        Text(
                          "Url",
                          style: TextStyle(
                            color: AppColors.c_D9D9D9,
                            fontSize: 19.w,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        10.getH(),
                        TextField(
                          controller: urlController,
                          style: TextStyle(
                            color: AppColors.c_D9D9D9.withOpacity(.34),
                            fontSize: 16.w,
                            fontWeight: FontWeight.w400,
                          ),
                          decoration: InputDecoration(
                            hintText: "Enter url",
                            hintStyle: TextStyle(
                              color: AppColors.c_D9D9D9.withOpacity(.34),
                              fontSize: 16.w,
                              fontWeight: FontWeight.w400,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.w),
                              borderSide: BorderSide(
                                color: AppColors.c_D9D9D9,
                                width: 1.w,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(6.w),
                              borderSide: BorderSide(
                                color: AppColors.c_D9D9D9,
                                width: 1.w,
                              ),
                            ),
                          ),
                        ),
                        56.getH(),
                        Center(
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: 15.h,
                                horizontal: 15.w,
                              ),
                              backgroundColor: AppColors.c_FDB623,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6.w),
                              ),
                            ),
                            onPressed: () {
                              QrImageView(
                                data: urlController.text,
                                version: QrVersions.auto,
                                size: 200.0,
                              );
                              context.read<ProductBloc>().add(
                                    AddProductEvent(
                                      productModel: ProductModel(
                                        name: nameController.text,
                                        qrCode: urlController.text,
                                        id: DateTime.now().millisecond,
                                        description: "New Product",
                                        dateTime: DateTime.now().toString(),
                                      ),
                                    ),
                                  );
                            },
                            child: Text(
                              "Generate QR Code",
                              style: TextStyle(
                                color: AppColors.c_333333,
                                fontSize: 16.w,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
