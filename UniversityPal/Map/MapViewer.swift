//
//  MapViewer.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 09/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import SwiftUI
import Firebase
import CoreLocation
import MapKit

struct MapViewer: View {
    var body: some View {
        
        mapView()
    }
}

struct MapViewer_Previews: PreviewProvider {
    static var previews: some View {
        MapViewer()
    }
}


struct mapView : UIViewRepresentable {

    func makeCoordinator() -> mapView.Coordinator {
        return mapView.Coordinator()
    }

    let map = MKMapView()
    let manager = CLLocationManager()
    
    func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView{
        
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
        manager.requestWhenInUseAuthorization()
        return map
    }
    
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
    }
    
    class Coordinator : NSObject, CLLocationManagerDelegate{
        
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied {
                
                print("denied")
            }
            if status == .authorizedWhenInUse{
                
                
                print("authorized")
            }
        }
        
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let last = locations.last
            //print (last?.coordinate.latitude)
            
        }
    }
    
}
