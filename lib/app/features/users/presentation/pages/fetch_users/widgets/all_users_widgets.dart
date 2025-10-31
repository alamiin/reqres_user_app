import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:reqres_user_app/app/config/route/app_route.dart';
import 'package:reqres_user_app/app/core/constants/colors.dart';
import 'package:reqres_user_app/app/features/users/presentation/widgets/circular_image.dart';

import '../../../../data/model/user_model.dart';
import '../../../provider/user_provider.dart';
import '../../../widgets/text_style.dart';

class AllUsersWidgets extends StatefulWidget {
  final List<UserModel> userList;
  const AllUsersWidgets({super.key, required this.userList});

  @override
  State<AllUsersWidgets> createState() => _AllUsersWidgetsState();
}

class _AllUsersWidgetsState extends State<AllUsersWidgets> {

  final controller = ScrollController();
  @override
  void initState() {
    controller.addListener(scrollListener);
    super.initState();
  }

  void scrollListener(){
    if(controller.position.pixels == controller.position.maxScrollExtent){
      Provider.of<UserProvider>(context, listen: false).fetchScrollUsers();
    }
  }

  void _onArticlePressed(BuildContext context, UserModel userModel) {
    Navigator.pushNamed(context, AppRoute.userDetailsRoute, arguments: userModel);
  }

  Future<void> onRefresh()async{
    Provider.of<UserProvider>(context, listen: false).fetchUsers();
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView.builder(
        controller: controller,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: widget.userList.length,
        itemBuilder: (context,  index) {
          return InkWell(
            onTap: (){
              FocusScope.of(context).unfocus();
              _onArticlePressed(context, widget.userList[index]);
            },
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 10),
              padding: const EdgeInsets.all(12),
              child: Row(

                children: [

                  CircularImage(
                    imageUrl: widget.userList[index].avatar ?? "",
                    size: 50,
                    borderColor: grey200,
                  ),


                  const SizedBox(width: 10,),
                  Flexible(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("${widget.userList[index].firstName} ${widget.userList[index].lastName}",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: titleText(),
                        )
                      ],
                    ),
                  )

                ],
              ),
            ),
          );
        },

      ),
    );
  }
}
