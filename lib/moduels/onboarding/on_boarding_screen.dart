
import 'package:flutter/material.dart';
import 'package:shop_app/moduels/login/shop_login_screen.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/network/cache_helper.dart';
import 'package:shop_app/shared/styles/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class BoardingModel {
  final String image;
  final String title;
  final String body;

  BoardingModel({
    required this.image,
    required this.title,
    required this.body
});
}



class OnBoardingScreen extends StatefulWidget {

  @override
  State<OnBoardingScreen> createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController boardingController = PageController();

  List<BoardingModel> boarding = [
    BoardingModel(
      image: 'assets/images/onborading_1.jpg',
      body: 'On Boarding 1 Body' ,
      title:'On Boarding 1 Title'
    ),
    BoardingModel(
        image: 'assets/images/onborading_2.jpg',
        body: 'On Boarding 2 Body' ,
        title:'On Boarding 2 Title'
    ),
    BoardingModel(
        image: 'assets/images/onborading_3.jpg',
        body: 'On Boarding 3 Body' ,
        title:'On Boarding 3 Title'
    ),
  ];

  bool isLast = false ;

  void submit()
  {
    CacheHelper.saveData(key: 'onBoarding', value: true , ).then((value) {
      if(value)
        {
          navigateAndFinish(
              context,
              ShopLoginScreen());
        }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          defaultTextButton(
              function: submit,
              text: 'skip',
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: boardingController,
                onPageChanged: (int index){
                  if(index == boarding.length - 1)
                    {
                      setState(() {
                        isLast = true ;
                      });
                     }
                  else
                      {
                        setState(() {
                          isLast = false ;
                        });
                      }
                },
                itemBuilder: (context, index) => buildBoardingItem(boarding[index]) ,
                itemCount: boarding.length ,
              ),
            ),
            const SizedBox(height: 40.0,),
            Row(
              children: [
                SmoothPageIndicator(
                    controller: boardingController,
                    effect:  ExpandingDotsEffect(
                      dotColor: Colors.grey,
                      activeDotColor: defaultColor,
                      dotHeight: 10,
                      dotWidth: 10,
                      expansionFactor: 4 ,
                      spacing: 5.0,
                    ),
                    count: boarding.length),
                const Spacer(),
                FloatingActionButton(
                  onPressed: (){
                    if(isLast)
                      {
                        submit();
                      }else
                        {
                          boardingController.nextPage(
                            duration: Duration(
                              milliseconds: 750,
                            ),
                            curve: Curves.fastLinearToSlowEaseIn,
                          );
                        }
                  },
                  child: Icon(Icons.arrow_forward_ios),
                    ),
              ],
            ),
          ],
        ),
      ) ,
    );
  }

  Widget buildBoardingItem(BoardingModel model) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children:
    [
      Expanded(
        child: Image(
          image:AssetImage(model.image),
        ),
      ),
      const SizedBox(
        height: 40.0,
      ),
      Text(
        model.title,
        style: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 15.0,
      ),
      Text(
        model.body,
        style: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      const SizedBox(
        height: 40.0,
      ),
    ],
  );
}
