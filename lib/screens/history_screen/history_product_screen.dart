import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:qr_code_project/bloc/products_bloc.dart';
import 'package:qr_code_project/bloc/products_event.dart';
import 'package:qr_code_project/bloc/products_state.dart';
import 'package:qr_code_project/screens/create_screen/create_screen.dart';
import 'package:qr_code_project/screens/open_file_screen/open_file_screen.dart';
import 'package:qr_code_project/utils/app_img/app_img.dart';
import 'package:qr_code_project/utils/size/size_screen_all.dart';
import 'package:zoom_tap_animation/zoom_tap_animation.dart';
import '../../data/models/form_status.dart';
import '../../utils/app_colors/app_colors.dart';

class HistoryProductScreen extends StatefulWidget {
  const HistoryProductScreen({super.key});

  @override
  State<HistoryProductScreen> createState() => _HistoryProductScreenState();
}

class _HistoryProductScreenState extends State<HistoryProductScreen> {
  bool active = false;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: AppColors.c_333333,
      appBar: AppBar(
        backgroundColor: AppColors.c_333333,
        title: const Padding(
          padding: EdgeInsets.only(left: 25),
          child: Text(
            "History",
            style: TextStyle(
              fontSize: 27,
              color: AppColors.cd9,
            ),
          ),
        ),
        actions: [
          Container(
            height: 40,
            width: 40,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.black.withOpacity(.11),
            ),
            child: IconButton(
              onPressed: () {},
              icon: SvgPicture.asset(AppImg.menu),
            ),
          ),
          const SizedBox(width: 42),
        ],
      ),
      body: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.formStatus == FormStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.formStatus == FormStatus.error) {
            return Center(child: Text(state.statusText));
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 21),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(6),
                      color: AppColors.c_333333,
                    ),
                    width: width,
                    child: Row(
                      children: [
                        Expanded(
                          child: ZoomTapAnimation(
                            onTap: () {
                              active = !active;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              margin: const EdgeInsets.only(right: 5),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: !active
                                    ? AppColors.c_FDB623
                                    : AppColors.c_333333,
                              ),
                              child: const Center(
                                child: Text(
                                  "Scan",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: ZoomTapAnimation(
                            onTap: () {
                              active = !active;
                              setState(() {});
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(6),
                                color: active
                                    ? AppColors.c_FDB623
                                    : AppColors.c_333333,
                              ),
                              child: const Center(
                                child: Text(
                                  "Create",
                                  style: TextStyle(
                                    fontSize: 17,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ...List.generate(
                    state.products.length,
                    (index) => ZoomTapAnimation(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => OpenFileProductScreen(
                              productModel: state.products[index],
                            ),
                          ),
                        );
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(
                          vertical: 13.h,
                          horizontal: 13.w,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          color: Colors.black.withOpacity(.25),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SvgPicture.asset(
                              AppImg.qrCode,
                              width: 33.w,
                              color: AppColors.c_FDB623,
                            ),
                            15.getW(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20.h,
                                  width: 140.w,
                                  child: Text(
                                    state.products[index].qrCode,
                                    style: TextStyle(
                                      fontSize: 17.w,
                                      color: AppColors.cd9,
                                    ),
                                  ),
                                ),
                                5.getH(),
                                Text(
                                  state.products[index].description,
                                  style: TextStyle(
                                    fontSize: 12.w,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                ZoomTapAnimation(
                                  onTap: () {
                                    context.read<ProductBloc>().add(
                                        RemoveProductEvent(
                                            productId:
                                                state.products[index].id));
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(5.w),
                                    child: const Icon(
                                      Icons.delete_forever,
                                      color: AppColors.c_FDB623,
                                    ),
                                  ),
                                ),
                                5.getH(),
                                Text(
                                  state.products[index].dateTime
                                      .substring(0, 16),
                                  style: TextStyle(
                                    fontSize: 12.w,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
