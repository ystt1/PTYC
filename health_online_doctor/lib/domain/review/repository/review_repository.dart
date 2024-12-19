import 'package:dartz/dartz.dart';

abstract class ReviewRepository{
  Future<Either> getReview();
}