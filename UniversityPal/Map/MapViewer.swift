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
    
    @State var name = ""
    
    var body: some View {
        
        //mapView()
        
        NavigationView{
            
            VStack{
                    TextField("Enter Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if name != "" {
                    
                    NavigationLink(destination: mapView(name: self.name).navigationBarTitle("", displayMode: .inline)) {
                        
                        Text("Share Location")
                    }
                  
                }
                }.padding()
            .navigationBarTitle("Location sharing")
        }
    }
}

struct MapViewer_Previews: PreviewProvider {
    static var previews: some View {
        MapViewer()
    }
}


struct mapView : UIViewRepresentable {

    var name = ""
    func makeCoordinator() -> mapView.Coordinator {
        return mapView.Coordinator(parent1: self)
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
        
        var parent : mapView
        
        init(parent1 : mapView) {
            parent = parent1
        }
        
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
            
            let db = Firestore.firestore()
            
            db.collection("locations").document("sharing").setData(["updates" : [self.parent.name :
                GeoPoint(latitude: (last?.coordinate.latitude)!, longitude: (last?.coordinate.longitude)!)]])
            {   (err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
            
            //print (last?.coordinate.latitude)
                }
                print ("success")
        }
    }
    
}

}
