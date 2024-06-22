import 'dart:async';

import 'package:call_son/core/shared_functions/location.dart';
import 'package:call_son/feature/school_register/data/repo/auth_repo_imp.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

part 'location_state.dart';

class LocationCubit extends Cubit<LocationState> {
  LocationCubit(this.authRepo) : super(LocationInitial());
  final SchoolAuthRepoImplementation authRepo;
  static LocationCubit get(context) => BlocProvider.of(context);

  Position? currentLocation;
  final Completer<GoogleMapController> controller = Completer<GoogleMapController>();
  CameraPosition? kGooglePlex;

  bool useCurrent = true;
  bool useAnother = false;
  List<Marker> markers =[] ;

  void init(context) async
  {
    await LocationManager.getPermission(context: context);
    currentLocation = await LocationManager.getCurrentLocation();
    print(currentLocation!.latitude);
    print(currentLocation!.longitude);
    setLocationToCurrent();
  }

  void setLocationToCurrent()
  {
    LatLng latLng = LatLng(currentLocation!.latitude, currentLocation!.longitude);
    kGooglePlex = CameraPosition(
      target: latLng,
      zoom: 14.4746,
    );
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('1'), position: latLng));
    emit(ChangeLocation());
  }

  void chooseUserCurrent(bool? value)
  {
    useCurrent = value!;
    useAnother = !value;
    currentLocationCheck();
  }
  void chooseAnotherLocation(bool? value)
  {
    useAnother = value!;
    useCurrent = !value;
    currentLocationCheck();
  }
  void currentLocationCheck()
  {
    if(useCurrent)
    {
      markers.clear();
      setLocationToCurrent();
    }
    else
    {
      emit(ChangeLocation());
    }
  }
  void mapOnTap(LatLng latLng)
  {
    markers.clear();
    markers.add(Marker(markerId: const MarkerId('1'), position: latLng));
    emit(ChangeLocation());
  }


}
