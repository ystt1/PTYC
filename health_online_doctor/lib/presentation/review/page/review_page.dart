import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online_doctor/domain/review/entity/review.dart';
import 'package:health_online_doctor/presentation/review/bloc/get_review_cubit.dart';
import 'package:health_online_doctor/presentation/review/bloc/get_review_state.dart';

class ReviewPage extends StatelessWidget {
  const ReviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(create: (BuildContext context) {
      var cubit = GetReviewCubit();
      cubit.getReview();
      return cubit;
    }, child: Container(
      child: BlocBuilder<GetReviewCubit, GetReviewState>(
          builder: (BuildContext context, GetReviewState state) {
        if (state is GetReviewStateLoading) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
        if (state is GetReviewStateFailure) {
          return Center(
            child: Text(state.errorMsg),
          );
        }
        if (state is GetReviewStateSuccess) {
          if (state.reviews.isEmpty)
            return Center(
              child: Text('don\'t have any review yet'),
            );
          return _reviews(context, state.reviews);
        }
        return Center(
          child: Text('Some thing went wrong'),
        );
      }),
    ));
  }

  Widget _reviews(BuildContext context, List<ReviewEntity> reviews) {
    return ListView.builder(
      itemCount: reviews.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  blurRadius: 4,
                  spreadRadius: 0,
                  offset: Offset(0, 0),
                )
              ],
              borderRadius: BorderRadius.circular(5)),
          child:  Row(
            children: [
              CircleAvatar(
                child: Icon(Icons.person),
              ),
              SizedBox(
                width: 20,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                            flex: 3,
                            child: Text(
                              reviews[index].userName,
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold),
                            )),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                            flex: 1,
                            child: Row(
                              children: [
                                Text(reviews[index].star.toString()),
                                Icon(
                                  Icons.star,
                                  color: Colors.yellowAccent,
                                )
                              ],
                            )),
                        SizedBox(
                          width: 40,
                        ),
                        Expanded(
                            flex: 3,
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Text(
                                reviews[index].dateTime,
                                style: TextStyle(color: Colors.grey),
                              ),
                            ))
                      ],
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Text(
                      reviews[index].comment,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
