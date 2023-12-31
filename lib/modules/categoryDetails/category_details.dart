import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Shop/layout/cubit/home_layout_cubit.dart';
import 'package:Shop/layout/cubit/home_layout_states.dart';
import 'package:Shop/models/categoryDetailsModel.dart';
import 'package:Shop/modules/productDetails/product_details.dart';
class CategoryDetails extends StatelessWidget {
  final int? id;
  CategoryDetails({required this.id});
  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<HomeLayoutCubit>(context)..getCategoryDetail(catId: id),
      child: BlocConsumer<HomeLayoutCubit,HomeLayoutStates>(
        builder:(context,state)=> Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.purple),),
          body: HomeLayoutCubit.get(context).categoyDetails == null || state is LoadingGetCAtegoryDetailsData ? Padding(
          padding: const EdgeInsets.symmetric(horizontal: 50.0),
          child: Center(child: LinearProgressIndicator(color: Colors.purple,)),
        ) :
        Container(
          color: Colors.grey[200],
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(HomeLayoutCubit.get(context).categoyDetails!.data.data.length, (index) => productsView(HomeLayoutCubit.get(context).categoyDetails,index,context)),),
        ),),
        listener: (context,state){
          if(state is SuccessGetCAtegoryDetailsData)
            {

            }
        },
      ),
    );
  }
}
Widget productsView(CategoryDetailsModel? model,index,context){
  return GestureDetector(
    onTap: (){
      Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductDetails(
          model!.data.data[index].id
      )));
    },
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0.5,vertical: 0.5),
      child: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Column(
            children: [
              Expanded(child: Image.network(model!.data.data[index].image)),
              Text(model.data.data[index].name),
              SizedBox(height: 5,),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("${model.data.data[index].price.toString()} EGP",style: TextStyle(color: Colors.purple),),
                  ),
                  model.data.data[index].discount !=0 ? Text(model.data.data[index].oldPrice.toString(),style: TextStyle(color: Colors.grey[400],decoration: TextDecoration.lineThrough),):Text(""),
                ],
              ),
              SizedBox(height: 8,),
            ],
          ),
        ),
      ),
    ),
  );
}