
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app/moduels/search/cubit/cubit.dart';
import 'package:shop_app/moduels/search/cubit/states.dart';
import 'package:shop_app/shared/components/components.dart';

class SearchScreen extends StatelessWidget {

  var formkey = GlobalKey<FormState>();
  var textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit , SearchStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: Form(
              key: formkey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    defaultTextFeild(
                        controller: textController,
                        type: TextInputType.text,
                        label: 'Search',
                        prefix: Icons.search,
                        validate: (value){
                          if(value!.isEmpty){
                            return('you should input text');
                          }
                        },
                       onSubmit: (String text) {
                         SearchCubit.get(context).search(text);
                       },
                    ),
                    const SizedBox(height: 10,),
                    if(state is SearchLoadingState)
                    const LinearProgressIndicator(),
                    const SizedBox(height: 10,),
                    if(state is SearchSuccessState)
                    Expanded(
                      child: ListView.separated(
                        itemBuilder: (context, index) =>  buildListProduct (
                            SearchCubit.get(context).model!.data!.data[index],
                            context , isOldPrice: false),
                        separatorBuilder: (context, index) => myDivider(),
                        itemCount: SearchCubit.get(context).model!.data!.data.length ,
                      ),
                    ) ,
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );

  }
}
