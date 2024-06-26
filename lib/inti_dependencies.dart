import 'package:blogapp/core/common/cubits/app_user/app_user_cubit.dart';
import 'package:blogapp/core/network/interner_connection.dart';
import 'package:blogapp/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:blogapp/features/auth/domain/repository/auth_repository.dart';
import 'package:blogapp/features/auth/domain/usecases/current_user.dart';
import 'package:blogapp/features/auth/domain/usecases/user_login.dart';
import 'package:blogapp/features/auth/domain/usecases/user_sign_out.dart';
import 'package:blogapp/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:blogapp/features/blog/data/dataSources/blog_remote_data_source.dart';
import 'package:blogapp/features/blog/data/repositories/blog_repository_impl.dart';
import 'package:blogapp/features/blog/domain/repositories/blog_repository.dart';
import 'package:blogapp/features/blog/domain/usecase/get_all_blogs.dart';
import 'package:blogapp/features/blog/domain/usecase/upload_blog.dart';
import 'package:blogapp/features/blog/presentation/bloc/blog_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'core/secrets/supabase_sectets.dart';
import 'features/auth/data/dataSources/auth_supabase_data.dart';
import 'features/auth/domain/usecases/user_signup.dart';

part 'init_depedencies_logic.dart';
