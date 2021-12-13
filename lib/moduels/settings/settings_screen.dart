
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/layout/cubit/cubit.dart';
import 'package:shop_app/layout/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';
import 'package:shop_app/shared/components/constants.dart';

class SettingsScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return BlocConsumer<ShopCubit , ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
      var model = ShopCubit.get(context).userModel;

      /*emailController.text = model!.data!.email!;
      nameController.text = model.data!.name!;
      phoneController.text = model.data!.phone!;*/

     return ConditionalBuilder(
        condition: ShopCubit.get(context).userModel != null ,
        builder:(context) => Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formkey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  if(state is ShopLoadingUpdateUserState )
                  const LinearProgressIndicator(),
                  const SizedBox(height: 20.0,),
                  defaultTextFeild(
                    controller: nameController,
                    type: TextInputType.text,
                    label: 'Name',
                    prefix: Icons.person,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return('name must not be empty');
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  defaultTextFeild(
                    controller: emailController,
                    type: TextInputType.emailAddress,
                    label: 'Email Address',
                    prefix: Icons.email,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return('email must not be empty');
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  defaultTextFeild(
                    controller: phoneController,
                    type: TextInputType.phone,
                    label: 'Phone',
                    prefix: Icons.phone,
                    validate: (value){
                      if(value!.isEmpty)
                      {
                        return('phone must not be empty');
                      }
                      return '';
                    },
                  ),
                  const SizedBox(height: 20.0,),
                  defaultButton(
                      function: ()
                      {
                        if(formkey.currentState!.validate())
                        {
                          ShopCubit.get(context).updateUserData(
                            name: nameController.text,
                            email: emailController.text,
                            phone: phoneController.text,
                          );
                        }
                      },
                      text: 'update'
                  ),
                  const SizedBox(height: 20.0,),
                  defaultButton(
                      function: ()
                      {
                        signOut(context);
                      },
                      text: 'logout'
                  ),
                ],
              ),
            ),
          ),
        ) ,
        fallback: (context) => const Center(child: CircularProgressIndicator()),
      );
    } ,
    );
  }
}
