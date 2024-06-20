import 'dart:io';


import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:smartsummarizer/Core/Constants/app_colors.dart';
import 'package:smartsummarizer/Widgets/custom_button.dart';

class UpLoadeFile extends StatefulWidget {
  final Function(File?) upLoadeFile;

  final File? file;

  const UpLoadeFile({
    required this.upLoadeFile,
    this.file,
    super.key,
  });

  @override
  State<UpLoadeFile> createState() => _UpLoadeFileState();
}

class _UpLoadeFileState extends State<UpLoadeFile> {
  FilePickerResult? result;
  File? file;
  @override
  void initState() {
    super.initState();
    if (widget.file != null) {
      file = widget.file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.w),
          border: Border.all(color: AppColors.primaryColor)),
      child: Row(
        children: [
          Expanded(
              child: CustomButton(
                  onPressed: () async {
                    result = await FilePicker.platform.pickFiles();
                    file = File(result!.files.single.path!);
                    widget.upLoadeFile(file);
                    setState(() {});
                  },
                  buttonText: "Select")),
          Expanded(
              child: Text(
            file != null ? "Done" : "Pdf",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 12.sp, fontWeight: FontWeight.bold),
          ))
        ],
      ),
    );
  }
}
