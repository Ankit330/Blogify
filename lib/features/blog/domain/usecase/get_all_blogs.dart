import 'package:blogapp/core/error/failures.dart';
import 'package:blogapp/core/usecase/usecase.dart';
import 'package:blogapp/features/blog/domain/entities/blog.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:fpdart/fpdart.dart';

class GetAllBlogs implements UseCase<List<Blog>, NoParam> {
  final BlogRepository blogRepository;

  GetAllBlogs(this.blogRepository);
  @override
  Future<Either<Failures, List<Blog>>> call(NoParam p) async {
    return await blogRepository.getAllBlogs();
  }
}
