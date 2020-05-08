//
//  MapView.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 08/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
  
  var locationManager = CLLocationManager()
  func setupManager() {
    locationManager.desiredAccuracy = kCLLocationAccuracyBest
    locationManager.requestWhenInUseAuthorization()
    locationManager.requestAlwaysAuthorization()
  }
  
  func makeUIView(context: Context) -> MKMapView {
    setupManager()
    let mapView = MKMapView(frame: UIScreen.main.bounds)
    mapView.showsUserLocation = true
    mapView.userTrackingMode = .follow
    return mapView
  }
  
  func updateUIView(_ uiView: MKMapView, context: Context) {
  }
}

struct MapView_Previews: PreviewProvider {
    static var previews: some View {
        ///*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
        MapView()
    }
}
