import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';


class CustomBottomBar extends StatelessWidget {
  final TabController controller;

  const CustomBottomBar({
    required this.controller,
  });
  @override
  Widget build(BuildContext context) {

    return BottomAppBar( //bottom navigation bar on scaffold
      color:Colors.white,
      shape: CircularNotchedRectangle(), //shape of notch
      notchMargin: 5, //notche margin between floating button and bottom appbar
      child: Row( //children inside bottom appbar
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[

          Padding(
            padding: const EdgeInsets.only(left:88.0),
            child: IconButton(icon: Icon(Icons.home, color: Colors.black,),  onPressed: () {
              controller.animateTo(0);
            }),
          ),

          // IconButton(icon: Icon(Icons.favorite, color: Colors.black,), onPressed: (){
          //   controller.animateTo(2);            }),

          Padding(
            padding: const EdgeInsets.only(right: 58.0),
            child: IconButton(icon: Icon(Icons.person, color: Colors.black,), onPressed: () {  controller.animateTo(1);},),
          ),

        ],
      ),
    );



    //   BottomAppBar(
    //   child: Row(
    //     mainAxisAlignment: MainAxisAlignment.spaceAround,
    //     children: <Widget>[
    //       IconButton(
    //         icon: SvgPicture.asset(
    //           'assets/icons/home_icon.svg',
    //           fit: BoxFit.fitWidth,
    //         ),
    //         onPressed: () {
    //           controller.animateTo(0);
    //         },
    //       ),
    //       IconButton(
    //         icon: Image.asset('assets/icons/category_icon.png'),
    //         onPressed: () {
    //           controller.animateTo(1);
    //         },
    //       ),
    //       // IconButton(
    //       //   icon: SvgPicture.asset('assets/icons/cart_icon.svg'),
    //       //   onPressed: () {
    //       //     controller.animateTo(2);
    //       //   },
    //       // ),
    //       IconButton(
    //         icon: Image.asset('assets/icons/profile_icon.png'),
    //         onPressed: () {
    //           controller.animateTo(3);
    //         },
    //       )
    //     ],
    //   ),
    // );
  }
}
