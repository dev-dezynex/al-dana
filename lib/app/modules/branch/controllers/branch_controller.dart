import 'dart:async';
import 'dart:ui' as ui;
import 'package:al_dana/app/routes/app_pages.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:al_dana/app/data/data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class BranchController extends GetxController {
  var isLoading = false.obs;
  Completer<GoogleMapController> mapController = Completer();
  var camPosition = const CameraPosition(
    target: LatLng(8.5678277, 76.8929361),
    zoom: 14.4746,
  ).obs;
  var originLocation = const LatLng(8.5678277, 76.8929361);
  var destinationLocation = const LatLng(8.5704811, 76.8752231);
  var polylineCoordinates = <LatLng>[].obs;
  LocationData? currentLocation;
  var branchResult = BranchResult().obs;
  var markers = <Marker>{}.obs;
  late BitmapDescriptor customIconSelected, customIconUnSelected;
  var selectedBranch = Branch().obs;
  @override
  void onInit() {
    super.onInit();
    getDetails();
  }

  addMarker() async {
// make sure to initialize before map loading
    customIconSelected = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        'assets/images/img_marker_selected.png');
    customIconUnSelected = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(size: Size(12, 12)),
        'assets/images/img_marker_unselected.png');
  }

  getDetails() async {
    isLoading(true);
    await getCurrentLocation();

    await addMarker();

    await getBranches();
    isLoading(false);
  }

  getCurrentLocation() async {
    Location location = Location();
    currentLocation = await location.getLocation();
  }

  getBranches() async {
    branchResult.value = await BranchProvider().getBranches();
    branchResult.refresh();

    for (Branch branch in branchResult.value.branchList!) {
      branch.distance = calculateDistance(branch.latitude, branch.longitude,
          currentLocation!.latitude, currentLocation!.longitude);
    }

    branchResult.value.branchList!.sort(
      (a, b) => a.distance.compareTo(b.distance),
    );

    selectBranch(branchResult.value.branchList![0] );
  }

  void setMarkers() {
    // Create a new marker
    print('adding markers ${markers.length}');
    markers.clear();
    for (int i = 0; i < branchResult.value.branchList!.length; i++) {
      Marker resultMarker = Marker(
        markerId: MarkerId(branchResult.value.branchList![i].id),
        infoWindow: InfoWindow(title: branchResult.value.branchList![i].name),
        position: LatLng(branchResult.value.branchList![i].latitude,
            branchResult.value.branchList![i].longitude),
        icon: selectedBranch.value.id == branchResult.value.branchList![i].id
            ? customIconSelected
            : customIconUnSelected,
      );

      // Add it to Set
      markers.add(resultMarker);
    }
    print('adding markers ${markers.length}');
    print('markers $markers');
    markers.refresh();
  }

  selectBranch(Branch branch) {
    selectedBranch.value = branch;
    setMarkers();
    moveCamera();
  }

  Future<void> moveCamera() async {
    final GoogleMapController controller = await mapController.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target:
          LatLng(selectedBranch.value.latitude, selectedBranch.value.longitude),
      zoom: 14.4746,
    )));
  }

  Future<BitmapDescriptor> _bitmapDescriptorFromSvgAsset(
      BuildContext context, String assetName) async {
    String svgString =
        await DefaultAssetBundle.of(context).loadString(assetName);
    //Draws string representation of svg to DrawableRoot
    DrawableRoot svgDrawableRoot = await svg.fromSvgString(svgString, '');
    ui.Picture picture = svgDrawableRoot.toPicture();
    ui.Image image = await picture.toImage(26, 37);
    ByteData? bytes = await image.toByteData(format: ui.ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(bytes!.buffer.asUint8List());
  }

  void onConfirmPressed() {
    if (selectedBranch.value.id.isNotEmpty) {
      storage.write(selected_branch, selectedBranch.value.toJson());
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.snackbar('Error', 'Please select a branch for confirm.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: textDark20,
          colorText: textDark80);
    }
  }
}
