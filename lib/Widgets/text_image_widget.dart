import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Widgets/custom_text.dart';

class TextImageWidget extends StatefulWidget {
  final Function(File)? selectNewImage;
  final File? fileImage;

  const TextImageWidget({
    this.fileImage,
    super.key,
    this.selectNewImage,
  });

  @override
  State<TextImageWidget> createState() => _TextImageWidgetState();
}

class _TextImageWidgetState extends State<TextImageWidget> {
  String? selctedImage;
  String? currantImage;

  @override
  void initState() {
    super.initState();

    if (widget.fileImage != null) {
      selctedImage = widget.fileImage!.path;
    }
  }

  Widget imageTypeWidget() {
    if (selctedImage != null) {
      return Container(
          height: 20.h,
          width: double.infinity,
          decoration: BoxDecoration(
              color: AppColors.greyColor,
              borderRadius: BorderRadius.circular(4.w),
              image: DecorationImage(
                  image: FileImage(File(
                    selctedImage!,
                  )),
                  fit: BoxFit.cover)));
    } else {
      return Container(
        height: 20.h,
        width: double.infinity,
        decoration: BoxDecoration(
          color: AppColors.greyColor,
          borderRadius: BorderRadius.circular(4.w),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: imageTypeWidget(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: 2.w,
          ),
          child: SizedBox(
            height: 10.h,
            child: Card(
              child: IconButton(
                onPressed: () {
                  showImageDialog(context);
                },
                icon: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_box_outlined,
                      color: AppColors.primaryColor,
                      size: 5.w,
                    ),
                    CustomText(
                      textData: "Upload your image",
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future showImageDialog(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: CustomText(
                textData: "Choose the image",
                textAlign: TextAlign.center,
                textColor: AppColors.primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
              content: SizedBox(
                height: 20.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: MaterialButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                final file = await picker.pickImage(
                                    source: ImageSource.gallery);
                                if (file != null) {
                                  widget.selectNewImage!(File(file.path));
                                  setState(() {
                                    currantImage = null;
                                    selctedImage = file.path;
                                  });
                                }

                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.photo,
                                    size: 25.w,
                                    color: AppColors.primaryColor,
                                  ),
                                  Text(
                                    "Gallery",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Expanded(
                            child: MaterialButton(
                              onPressed: () async {
                                ImagePicker picker = ImagePicker();
                                final file = await picker.pickImage(
                                    source: ImageSource.camera);
                                if (file != null) {
                                  widget.selectNewImage!(File(file.path));
                                  setState(() {
                                    currantImage = null;
                                    selctedImage = file.path;
                                  });
                                }
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera,
                                    size: 25.w,
                                    color: AppColors.primaryColor,
                                  ),
                                  Text(
                                    "Camera",
                                    style: TextStyle(
                                        color: AppColors.primaryColor,
                                        fontSize: 14.sp),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ));
  }
}
