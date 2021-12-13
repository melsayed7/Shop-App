import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/shared/styles/colors.dart';

Widget defaultButton ({
   double width = double.infinity,
   Color background = Colors.blue,
   bool isUppercase = true ,
   double radius =5.0 ,
   Function()? function,
   required String text ,
}) =>
Container(
   width: width,
  child: MaterialButton(
    onPressed: function ,
    child:  Text(
      isUppercase ? text.toUpperCase() : text ,
      style: TextStyle(fontSize: 20.0, color: Colors.white),
    ),
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(radius),
    color: background,
  ),
);

Widget defaultTextButton({
  required Function()? function,
  required String text ,
}) =>
TextButton(
  onPressed: function,
  child: Text(text.toUpperCase()),
  );

Widget defaultTextFeild ({
  required TextEditingController controller,
  required TextInputType type ,
  required String label,
  required IconData prefix ,
  required String? Function(String?)? validate ,
  bool isPassword = false,
  IconData? suffix ,
  Function()? suffixPressed ,
  Function()? ontaped ,
  Function(String)? onSubmit,
  ValueChanged<String>? onchange ,
  }) => TextFormField(
  controller: controller,
  keyboardType: type,
  validator: validate,
  onFieldSubmitted: onSubmit ,
  onTap: ontaped ,
  onChanged: onchange ,
  obscureText: isPassword ,
  decoration:  InputDecoration(
    prefixIcon: Icon(prefix),
    labelText: label ,
    suffixIcon: suffix != null ? IconButton(
      onPressed: suffixPressed ,
        icon: Icon(suffix)) : null ,
    border: OutlineInputBorder(),
  ),
);

/*Widget buildTaskItem (Map model , context) => Dismissible(
  key: Key(model['id'].toString()),
  child:   Padding(
    padding: const EdgeInsets.all(20.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 40.0,
          child: Text(
            '${model['time']}',
          ),
        ),
        SizedBox(width: 20.0,),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                '${model['title']}',
                style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(

                '${model['date']}',

                style: TextStyle(

                  color: Colors.grey,

                ),

              ),
            ],
          ),
        ),
        SizedBox(width: 20.0,),

        IconButton(
            onPressed: (){
              AppCubit.get(context).updateDatabase(
                  status: 'done',
                  id: model['id']);
            },
            icon: Icon(

              Icons.check_box,

              color: Colors.green,

            )),
        IconButton(

            onPressed: (){

              AppCubit.get(context).updateDatabase(

                  status: 'archive',

                  id: model['id']);

            },

            icon: Icon(

              Icons.archive,

              color: Colors.grey,

            )),
      ],

    ),
  ),
  onDismissed: (direction) {
    AppCubit.get(context).deleteDatabase(id: model['id']);
  },
);*/

/*Widget taskBiulder ({required List<Map> tasks,}) => ConditionalBuilder(
  condition: tasks.length > 0,
  builder: (context) =>  ListView.separated(
      itemBuilder: (context, index) => buildTaskItem(tasks[index] , context),
      separatorBuilder: (context, index) => myDivider(),
      itemCount: tasks.length
  ),
  fallback: (context) => Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
            Icons.menu,
            size: 100.0,
            color: Colors.grey
        ),
        Text(
          'No Tasks Yet , PLZ entre some tasks',
          style: TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.bold,
              color: Colors.grey
          ),
        ),
      ],
    ),
  ),
);*/

Widget myDivider () => Container(
  width: double.infinity,
  height: 1,
  color: Colors.grey[300],
);

Widget buildArticleItem (article , context) => InkWell(
  onTap: (){
    //navigateTO(context, WebViewScreen(article['url']),);
  },
  child:   Padding(

    padding: const EdgeInsets.all(20.0),



    child: Row(



      children: [



        Container(



          width: 120.0,



          height: 120.0,



          decoration: BoxDecoration(



            borderRadius: BorderRadius.circular(10.0),



            image:DecorationImage(



              image: NetworkImage('${article['urlToImage']}'),



              fit: BoxFit.cover,



            ),



          ),



        ),



        SizedBox(



          width: 18.0,



        ),



        Expanded(



          child: Container(



            height: 120.0,



            child: Column(



              crossAxisAlignment: CrossAxisAlignment.start,



              mainAxisAlignment: MainAxisAlignment.start,



              children: [



                Expanded(



                  child: Text(



                    '${article['title']}',



                    style: Theme.of(context).textTheme.bodyText1,



                    maxLines: 3,



                    overflow: TextOverflow.ellipsis,



                  ),



                ),



                Text(



                  '${article['publishedAt']}',



                  style: TextStyle(



                    color: Colors.grey,



                  ),



                ),



              ],



            ),



          ),



        ),



      ],



    ),



  ),
);

Widget articleBuilder (list,context,{isSearch = false}) => ConditionalBuilder(
  condition: list.length > 0,
  builder: (context) => ListView.separated(
    physics: BouncingScrollPhysics(),
    itemBuilder: (context, index) => buildArticleItem(list[index],context) ,
    separatorBuilder: (context, index) => myDivider(),
    itemCount: 20 ,
  ) ,
  fallback: (context) => isSearch ? Container() : Center(child: CircularProgressIndicator(),),
);

void navigateTO( context, widget) =>  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (context) => widget,
  ),
);

void navigateAndFinish( context, widget) =>  Navigator.pushAndRemoveUntil(
  context,
  MaterialPageRoute (
    builder: (context) => widget,
  ),
    (Route<dynamic> route) => false ,
);

void showToast ({
  required String text ,
  required ToastStates state ,
}) =>  Fluttertoast.showToast(
    msg: text ,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 5,
    backgroundColor: chooseToastColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastStates {SUCCESS , ERROR ,WARNING}

Color chooseToastColor (ToastStates state)
{
  Color color ;
  switch(state)
  {
    case ToastStates.SUCCESS:
      color= Colors.green;
      break;
    case ToastStates.ERROR:
      color= Colors.red;
      break;
    case ToastStates.WARNING:
      color= Colors.amber;
      break;
  }
  return color ;
}

Widget buildListProduct ( model , context , { bool isOldPrice = true,}) => Padding(
  padding: const EdgeInsets.all(20.0),
  child: Container(
    height: 120.0,
    child: Row(
      children: [
        Stack(
          alignment: AlignmentDirectional.bottomStart,
          children: [
            Image(
              image: NetworkImage(model!.image),
              width: 120.0,
              height: 120.0,
              //fit: BoxFit.cover,
            ),
            if(model.discount != 0 && isOldPrice )
              Container(
                color: Colors.red,
                padding: EdgeInsets.symmetric(horizontal: 5.0,),
                child: Text(
                  'DISCOUNT',
                  style: TextStyle(
                    fontSize: 10.0,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        ),
        const SizedBox(
          width: 20.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                model.name,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 14.0,
                  height: 1.3,
                ),
              ),
              Spacer(),
              Row(
                children: [
                  Text(
                    model.price.toString(),
                    style: TextStyle(
                      fontSize: 12.0,
                      color: defaultColor,
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                  if(model.discount != 0 && isOldPrice)
                    Text(
                      model.oldPrice.toString(),
                      style: TextStyle(
                        fontSize: 10.0,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  const Spacer(),
                  IconButton(
                    onPressed: (){
                      //print(model.id);
                      ShopCubit.get(context).changeFavorites(model.id);
                    },
                    icon: CircleAvatar(
                      radius: 15.0,
                      backgroundColor:
                      ShopCubit.get(context).favorites[model.id]??false
                          ? defaultColor
                          : Colors.grey,
                      child: Icon(
                        Icons.favorite_border,
                        size: 14.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    ),
  ),
);