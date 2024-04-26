part of 'inti_dependencies.dart';

final serviceLocator = GetIt.instance;

Future<void> initDependencies() async {
  _initAuth();
  _initBlog();
  final supabase = await Supabase.initialize(
    anonKey: SupabaseSecrets.supabaseAPI,
    url: SupabaseSecrets.supabaseURL,
  );
  serviceLocator.registerLazySingleton(() => supabase.client);

  //core
  serviceLocator.registerLazySingleton(() => AppUserCubit());
  serviceLocator.registerFactory(() => InternetConnection());
  serviceLocator
      .registerFactory<ConnectionChecker>(() => InternetConnectionImpl(
            serviceLocator(),
          ));
}

void _initAuth() {
  serviceLocator.registerFactory<AuthSupabaseDataSource>(
    () => AuthSupabaseDataSourceImp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<AuthRepository>(
    () => AuthRepositoriesImpl(
      serviceLocator(),
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<UserSignUp>(
    () => UserSignUp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<UserLogin>(
    () => UserLogin(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<UserSignOut>(
    () => UserSignOut(
      serviceLocator(),
    ),
  );

  serviceLocator.registerFactory<CurrentUser>(
    () => CurrentUser(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => AuthBloc(
      currentUser: serviceLocator(),
      userSignUp: serviceLocator(),
      userSignOut: serviceLocator(),
      userLogin: serviceLocator(),
      appUserCubit: serviceLocator(),
    ),
  );
}

void _initBlog() {
  serviceLocator.registerFactory<BlogRemoteDataSource>(
    () => BlogRemoteDataSourceImp(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<BlogRepository>(
    () => BlogRepositoryImpl(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<UploadBlog>(
    () => UploadBlog(
      serviceLocator(),
    ),
  );
  serviceLocator.registerFactory<GetAllBlogs>(
    () => GetAllBlogs(
      serviceLocator(),
    ),
  );

  serviceLocator.registerLazySingleton(
    () => BlogBloc(
      uploadBlog: serviceLocator(),
      getAllBlogs: serviceLocator(),
    ),
  );
}
