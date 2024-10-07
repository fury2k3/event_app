import 'package:connectivity/connectivity.dart';
import 'package:event_app/core/network/network_info.dart';
import 'package:event_app/features/event/data/datasources/remote_data_source/event_remote_data_source.dart';
import 'package:event_app/features/event/data/repository/event_repository_impl.dart';
import 'package:event_app/features/event/domain/repository/event_repository.dart';
import 'package:event_app/features/event/domain/usecases/create_event_usecase.dart';
import 'package:event_app/features/event/domain/usecases/get_all_events_usecase.dart';
import 'package:event_app/features/event/domain/usecases/get_user_event_history_usecase.dart';
import 'package:event_app/features/event/domain/usecases/make_event_purchase_usecase.dart';
import 'package:event_app/features/event/presentation/bloc/event_bloc.dart';
import 'package:event_app/features/login/data/data_sources/local_data_source/auth_local_data_source.dart';
import 'package:event_app/features/login/data/data_sources/remote_data_source/auth_remote_data_source.dart';
import 'package:event_app/features/login/data/repository/auth_repository_impl.dart';
import 'package:event_app/features/login/domain/repository/auth_repository.dart';
import 'package:event_app/features/login/domain/usecases/auth_confirm_reset_code_use_case.dart';
import 'package:event_app/features/login/domain/usecases/auth_send_reset_code_use_case.dart';
import 'package:event_app/features/login/domain/usecases/auth_signin_usecase.dart';
import 'package:event_app/features/login/domain/usecases/auth_signup_usecase.dart';
import 'package:event_app/features/login/domain/usecases/auth_update_password_use_case.dart';
import 'package:event_app/features/login/domain/usecases/get_user_info_use_case.dart';
import 'package:event_app/features/login/domain/usecases/get_user_is_connected_use_case.dart';
import 'package:event_app/features/login/domain/usecases/logout_user_use_case.dart';
import 'package:event_app/features/login/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/payment/data/data_source/payment_remote_data_source.dart';
import 'package:event_app/features/payment/data/repository/payment_repository_impl.dart';
import 'package:event_app/features/payment/domain/repository/payment_repository.dart';
import 'package:event_app/features/payment/domain/usecases/pay_with_stripe_usecase.dart';
import 'package:event_app/features/payment/presentation/bloc/payment_bloc.dart';
import 'package:event_app/global/utils/const.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Payment
  // BLOC
  sl
    ..registerFactory(
      () => PaymentBloc(
        payWithStripeUseCase: sl(),
      ),
    )

    // UseCases
    ..registerLazySingleton(
      () => PayWithStripeUseCase(
        paymentRepository: sl(),
      ),
    )

    // ? Repository
    ..registerLazySingleton<PaymentRepository>(
      () => PaymentRepositoryImpl(
        paymentRemoteDataSource: sl(),
        networkInfo: sl(),
      ),
    )

    // ? DataSources
    ..registerLazySingleton<PaymentRemoteDataSource>(
      () => PaymentRemoteDataSourceImpl(
        client: sl(),
      ),
    )

    //*-------------------- Event module   --------------------

    ..registerFactory(
      () => EventBloc(
        createEventUseCase: sl(),
        getAllEventUseCase: sl(),
        makeEventPurchaseUseCase: sl(),
        getUserHistoryEventUseCase: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CreateEventUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetAllEventUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => MakeEventPurchaseUseCase(repository: sl()),
    )
    ..registerLazySingleton(
      () => GetUserHistoryEventUseCase(repository: sl()),
    )
    ..registerLazySingleton<EventRepository>(
      () => EventRepositoryImpl(
        eventRemoteDataSource: sl(),
        authLocalDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    ..registerLazySingleton<EventRemoteDataSource>(
      () => EventRemoteDataSourceImpl(
        client: sl(),
      ),
    )
    //*-------------------- Authentication module   --------------------
    // register bloc

    ..registerFactory(
      () => AuthBloc(
        authSignInUseCase: sl(),
        authSignUpUseCase: sl(),
        authSendResetCodeUseCase: sl(),
        authConfirmResetCodeUseCase: sl(),
        authUpdatePasswordUseCase: sl(),
        getUserIsConnectedUseCase: sl(),
        logoutUserUseCase: sl(),
        getUserInfoUseCase: sl(),
      ),
    )

    // register use-cases
    ..registerLazySingleton(
      () => AuthSignInUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AuthSignUpUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AuthSendResetCodeUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AuthConfirmResetCodeUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => AuthUpdatePasswordUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetUserIsConnectedUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => LogoutUserUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton(
      () => GetUserInfoUseCase(
        repository: sl(),
      ),
    )
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: sl(),
        authLocalDataSource: sl(),
        networkInfo: sl(),
      ),
    )

    // register data sources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(
        client: sl(),
        googleSignIn: sl(),
      ),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(
        sharedPreferences: sl(),
      ),
    );

  //*-------------------- Core  --------------------

  //! Core
  final sharedPreferences = await SharedPreferences.getInstance();

  sl
    ..registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()))
    ..registerLazySingleton(http.Client.new)
    ..registerLazySingleton(GoogleSignIn.new)
    ..registerLazySingleton(() => sharedPreferences)
    ..registerLazySingleton(Connectivity.new);
  Stripe.publishableKey = stripePublishableLiveKey;
}
