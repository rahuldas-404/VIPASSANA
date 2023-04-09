import 'package:flutter/material.dart';
import 'package:gsol_main/Widgets/app_large_text.dart';
import 'package:gsol_main/Widgets/app_text.dart';
import 'package:gsol_main/Widgets/responsive_button.dart';

import '../Page1.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  // State<Home> createState() => _HomeState();
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List images = [
    "img1.png",
    "img2.jpg",
    "img3.png",
    "img4.png"
  ];

  List text=[
    "File",
    "Record",
    "Activate",
    "Activate"
  ];

  List text2=[
    "Upload",
    "A Segment",
    "Live Translation",
    "Live Voice Translation"
  ];


  List text3=[
    "Upload a file from your local library for live translation",
    "Record A Segment",
    "Activate Live Translation",
    "Activate Live Voice Translation"
  ];


  // List text=[
  //
  // ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: images.length,
          itemBuilder: (_, index) {
            return Container(
              width: double.maxFinite,
              height: double.maxFinite,
              // width: double.infinity,
              // height: double.infinity,
              decoration:
                  BoxDecoration(image: DecorationImage(
                      image: AssetImage(
                      // ignore: prefer_interpolation_to_compose_strings
                      "img/" + images[index]
                      ),
                    fit: BoxFit.cover
                    )
                  ),
              child: Container(
                margin: const EdgeInsets.only(top:150, left: 20, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppLargeText(text: text[index]),
                        AppText(text: text2[index], size: 30, color: Colors.indigo,),
                        SizedBox(height: 20,),
                        Container(
                          width: 250,
                          child: AppText(
                            text: text3[index],
                            color: Colors.blueGrey,
                            size: 14,
                          ),
                        ),
                        SizedBox(height: 40,),
                        GestureDetector(
                          onTap: (){
                            if(index==2){
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => Page1()),
                              );
                            }
                          },
                            child: Container(
                              width: 200,
                              child: Row(children: [ ResponsiveButton(width: 150,)])),

                        )
                      ],
                    ),
                    Column(
                      children: List.generate(4, (indexDots){
                        return Container(
                          margin: const EdgeInsets.only(bottom: 5),
                          width: 8,
                          height: index==indexDots?30:13,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8),
                            color: index==indexDots?Colors.green:Colors.green.withOpacity(0.5)
                          ),
                        );
                      }),
                    )
                  ],
                ),
              ),
            );
          }),
    );
  }
}
