import 'package:get/get.dart';

import '../modules/add_booking/bindings/add_booking_binding.dart';
import '../modules/add_booking/views/add_booking_view.dart';
import '../modules/add_brand/bindings/add_brand_binding.dart';
import '../modules/add_brand/views/add_brand_view.dart';
import '../modules/add_category/bindings/add_category_binding.dart';
import '../modules/add_category/views/add_category_view.dart';
import '../modules/add_package/bindings/add_package_binding.dart';
import '../modules/add_package/views/add_package_view.dart';
import '../modules/add_service/bindings/add_service_binding.dart';
import '../modules/add_service/views/add_service_view.dart';
import '../modules/add_vehicle/bindings/add_vehicle_binding.dart';
import '../modules/add_vehicle/views/add_vehicle_view.dart';
import '../modules/add_work/bindings/add_work_binding.dart';
import '../modules/add_work/views/add_work_view.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/auth/views/auth_view.dart';
import '../modules/booking_page/bindings/booking_page_binding.dart';
import '../modules/booking_page/views/booking_page_view.dart';
import '../modules/branch/bindings/branch_binding.dart';
import '../modules/branch/views/branch_view.dart';
import '../modules/brand/bindings/brand_binding.dart';
import '../modules/brand/views/brand_view.dart';
import '../modules/category_list/bindings/category_list_binding.dart';
import '../modules/category_list/views/category_list_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/map_page/bindings/map_page_binding.dart';
import '../modules/map_page/views/map_page_view.dart';
import '../modules/package_list/bindings/package_list_binding.dart';
import '../modules/package_list/views/package_list_view.dart';
import '../modules/payment_page/bindings/payment_page_binding.dart';
import '../modules/payment_page/views/payment_page_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/service/bindings/service_binding.dart';
import '../modules/service/views/service_view.dart';
import '../modules/service_details/bindings/service_details_binding.dart';
import '../modules/service_details/views/service_details_view.dart';
import '../modules/service_list/bindings/service_list_binding.dart';
import '../modules/service_list/views/service_list_view.dart';
import '../modules/slider/bindings/slider_binding.dart';
import '../modules/slider/views/slider_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/track_page/bindings/track_page_binding.dart';
import '../modules/track_page/views/track_page_view.dart';
import '../modules/vehicle/bindings/vehicle_binding.dart';
import '../modules/vehicle/views/vehicle_view.dart';
import '../modules/work/bindings/work_binding.dart';
import '../modules/work/views/work_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.AUTH,
      page: () => AuthView(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.PROFILE,
      page: () => ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: _Paths.ADD_SERVICE,
      page: () => AddServiceView(),
      binding: AddServiceBinding(),
    ),
    GetPage(
      name: _Paths.WORK,
      page: () => const WorkView(),
      binding: WorkBinding(),
    ),
    GetPage(
      name: _Paths.ADD_WORK,
      page: () => AddWorkView(),
      binding: AddWorkBinding(),
    ),
    GetPage(
      name: _Paths.BRAND,
      page: () => const BrandView(),
      binding: BrandBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BRAND,
      page: () => const AddBrandView(),
      binding: AddBrandBinding(),
    ),
    GetPage(
      name: _Paths.VEHICLE,
      page: () => const VehicleView(),
      binding: VehicleBinding(),
    ),
    GetPage(
      name: _Paths.ADD_VEHICLE,
      page: () => const AddVehicleView(),
      binding: AddVehicleBinding(),
    ),
    GetPage(
      name: _Paths.MAP_PAGE,
      page: () => MapPageView(),
      binding: MapPageBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE,
      page: () => const ServiceView(),
      binding: ServiceBinding(),
    ),
    GetPage(
      name: _Paths.SLIDER,
      page: () => SliderView(),
      binding: SliderBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_DETAILS,
      page: () => const ServiceDetailsView(),
      binding: ServiceDetailsBinding(),
    ),
    GetPage(
      name: _Paths.BRANCH,
      page: () => const BranchView(),
      binding: BranchBinding(),
    ),
    GetPage(
      name: _Paths.PAYMENT_PAGE,
      page: () => const PaymentPageView(),
      binding: PaymentPageBinding(),
    ),
    GetPage(
      name: _Paths.BOOKING_PAGE,
      page: () => const BookingPageView(),
      binding: BookingPageBinding(),
    ),
    GetPage(
      name: _Paths.ADD_BOOKING,
      page: () => const AddBookingView(),
      binding: AddBookingBinding(),
    ),
    GetPage(
      name: _Paths.TRACK_PAGE,
      page: () => TrackPageView(),
      binding: TrackPageBinding(),
    ),
    GetPage(
      name: _Paths.SERVICE_LIST,
      page: () => const ServiceListView(),
      binding: ServiceListBinding(),
    ),
    GetPage(
      name: _Paths.CATEGORY_LIST,
      page: () => const CategoryListView(),
      binding: CategoryListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_CATEGORY,
      page: () =>  AddCategoryView(),
      binding: AddCategoryBinding(),
    ),
    GetPage(
      name: _Paths.PACKAGE_LIST,
      page: () => const PackageListView(),
      binding: PackageListBinding(),
    ),
    GetPage(
      name: _Paths.ADD_PACKAGE,
      page: () => const AddPackageView(),
      binding: AddPackageBinding(),
    ),
  ];
}
