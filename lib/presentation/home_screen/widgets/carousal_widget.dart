import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/show_products/show_all_products_bloc.dart';
import 'package:reciprocal_task/constants/colors.dart';

class Carousal extends StatelessWidget {
  final double kHeight;

  const Carousal({
    super.key,
    required this.kHeight,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: BlocBuilder<ShowAllProductsBloc, ShowAllProductsState>(
        builder: (context, state) {
          if (state is LoadingState) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is ShowFullProducts) {
            final List forCarousal = List.generate(
                5, (index) => state.fullProducts[index],
                growable: false);
            return CarouselSlider(
              options: CarouselOptions(height: kHeight),
              items: forCarousal.map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CachedNetworkImage(
                        imageUrl: "${i.image}",
                        placeholder: (context, url) =>
                          const  Center(child:  CircularProgressIndicator()),
                        imageBuilder: (context, imageProvider) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              color: kWhite,
                              boxShadow: const [
                                BoxShadow(
                                  blurRadius: 5,
                                  blurStyle: BlurStyle.outer,
                                  color: kGrey,
                                ),
                              ],
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(20)),
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.contain,
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  },
                );
              }).toList(),
            );
          } else {
            return const Center(
              child: Text("Somethimg went wrong"),
            );
          }
        },
      ),
    );
  }
}
