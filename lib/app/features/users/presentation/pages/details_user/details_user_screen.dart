import 'package:flutter/material.dart';
import 'package:reqres_user_app/app/core/constants/app_text_data.dart';
import 'package:reqres_user_app/app/features/users/data/model/user_model.dart';
import 'package:reqres_user_app/app/features/users/presentation/widgets/rectangle_image.dart';

import '../../widgets/text_style.dart';

class DetailsUserScreen extends StatelessWidget {
  final UserModel userModel;
  const DetailsUserScreen({super.key, required this.userModel});

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double imageSize = width - 40;
    double topSpace = imageSize * 0.25;
    double bottomSpace = topSpace * 0.5;
    return  Scaffold(
      appBar: AppBar(
        title: Text(AppTextData.profile, style: titleText(),),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                RectangleImage(
                  imageUrl: userModel.avatar ?? "",
                  height: imageSize,
                  width: imageSize,
                  borderColor: Colors.white70,
                ),

                SizedBox(height: bottomSpace,),

                Text( "${userModel.firstName} ${userModel.lastName}", style: titleText(),),
                Text( userModel.email, style: bodyText(),),
                const SizedBox(height: 10,),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
