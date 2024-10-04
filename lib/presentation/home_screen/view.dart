import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/show_products/show_all_products_bloc.dart';
import 'package:reciprocal_task/presentation/home_screen/widgets/all_products.dart';
import 'package:reciprocal_task/presentation/home_screen/widgets/carousal_widget.dart';
import 'package:reciprocal_task/presentation/home_screen/widgets/new_arrival.dart';
import 'package:reciprocal_task/presentation/home_screen/widgets/new_arrived_full.dart';
import 'package:reciprocal_task/presentation/home_screen/widgets/product_grid_tile.dart';
import 'package:reciprocal_task/presentation/product_view/view.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ShowAllProductsBloc>(context).add(GetProductsToShow());
    final kheight = MediaQuery.sizeOf(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Shoppie"),
      ),
      body: CustomScrollView(
        slivers: [
          SliverPadding(
            padding: const EdgeInsets.all(8.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Carousal(
                    kHeight: kheight.height * 0.25,
                  ),
                  SizedBox(height: kheight.height * 0.05),
                  const NewArrivalText(),
                  SizedBox(height: kheight.height * 0.05),
                  NewArrivedFull(kheight: kheight),
                  SizedBox(height: kheight.height * 0.05),
                  const AllProductText(),
                  SizedBox(height: kheight.height * 0.05),
                  BlocBuilder<ShowAllProductsBloc, ShowAllProductsState>(
                    builder: (context, state) {
                      if (state is LoadingState) {
                        return SizedBox(
                          height: kheight.height * 0.2,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      } else if (state is ShowFullProducts) {
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate:
                              const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 220,
                            crossAxisSpacing: 8,
                            mainAxisSpacing: 8,
                            childAspectRatio: 5,
                            mainAxisExtent: 260,
                          ),
                          itemBuilder: (context, index) => ProductGridTile(
                              anProductImg: state.fullProducts[index].image,
                              textProducts: state.fullProducts[index].category,
                              textPrice:
                                  state.fullProducts[index].price.toString(),
                              imageHeight: kheight.height * 0.15,
                              imageWidth: kheight.width * 0.5,
                              anProductId:
                                  state.fullProducts[index].id.toString(),
                              anOnPressed: () {
                                Navigator.push(
                                  context,
                                  CupertinoPageRoute(
                                    builder: (context) => ProductView(
                                      anProduct: state.fullProducts[index],
                                    ),
                                  ),
                                );
                              }),
                          itemCount: state.fullProducts.length,
                        );
                      } else {
                        return SizedBox(
                          height: kheight.height * 0.2,
                          child: const Center(
                            child: Text("Something went wrong"),
                          ),
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
