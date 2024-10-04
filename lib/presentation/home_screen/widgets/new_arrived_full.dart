
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:reciprocal_task/appliation/show_products/show_all_products_bloc.dart';
import 'package:reciprocal_task/presentation/home_screen/widgets/new_arrival_prodct.dart';

class NewArrivedFull extends StatelessWidget {
  const NewArrivedFull({
    super.key,
    required this.kheight,
  });

  final Size kheight;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShowAllProductsBloc, ShowAllProductsState>(
      builder: (context, state) {
        if (state is LoadingState) {
          return SizedBox(
            height: kheight.height * 0.2,
            child: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is ShowFullProducts) {
          return NewArrivalProduct(
              product: state.fullProducts[6],
              productName: state.fullProducts[6].title);
        } else {
          return const Center(
            child: Text("Something went wrong"),
          );
        }
      },
    );
  }
}
