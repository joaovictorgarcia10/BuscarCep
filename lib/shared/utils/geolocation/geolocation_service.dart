import 'package:clean_arch_aula/shared/core/error/failure.dart';
import 'package:clean_arch_aula/shared/utils/geolocation/geolocation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class GeolocationService {
  Future<Either<Failure, Geolocation>> getGeolocation() async {
    try {
      LocationPermission permission;
      bool actived = await Geolocator.isLocationServiceEnabled();

      if (!actived) {
        throw GeolocationNotActiveFailure().message;
      }

      permission = await Geolocator.checkPermission();

      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }

      if (permission == LocationPermission.denied) {
        throw GeolocationPermissionDeniedFailure().message;
      }

      if (permission == LocationPermission.deniedForever) {
        throw GeolocationPermissionDeniedFailure().message;
      }

      final currentPosition = await Geolocator.getCurrentPosition();

      Geolocation geolocation = Geolocation(
        latitude: currentPosition.latitude,
        longitude: currentPosition.longitude,
      );

      return Right(geolocation);
    } catch (e) {
      debugPrint("$e");
      return Left(Failure(message: ServerFailure().message));
    }
  }
}
