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

//for the bit where user enters name
//STRUCT
struct MapViewer: View {
    
    //hands control over to SwiftUI so that it remains persistent in memory for as long as the view exists.
    @State var name = ""
    
    //using an external reference type
    @ObservedObject var obs = observer()
    
    var body: some View {
        
        //mapView()
        
        NavigationView{
            
            VStack{
                    TextField("Enter Name", text: $name)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                
                if name != "" {
                    
                    NavigationLink(destination: mapView(name: self.name, geopoints: self.obs.data["data"] as! [String : GeoPoint]).navigationBarTitle("", displayMode: .inline)) {
                        
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

//UIViewRepresentable; A wrapper for a UIKit view that you use to integrate that view into your SwiftUI view hierarchy.

//STRUCT
struct mapView : UIViewRepresentable {

    var name = ""
    var geopoints : [String: GeoPoint]
    
    //creates the custom instance that we use to communicate changes from our view controller to other parts of your SwiftUI interface.
    //called before makeUIView()
    
    //FUNCTION
    func makeCoordinator() -> mapView.Coordinator {
        return mapView.Coordinator(parent1: self)
    }
    
    @ObservedObject var random = observer()

    let map = MKMapView()
    let manager = CLLocationManager()
    
    //can make annotations in this method using MKPointAnnotation()
    
    
    //make chnages to this so view provides users and their locations tappable etc
    //FUNCTION
    func makeUIView(context: UIViewRepresentableContext<mapView>) -> MKMapView{
        
        map.delegate = context.coordinator
        //shows the user location
        manager.delegate = context.coordinator
        manager.startUpdatingLocation()
        map.showsUserLocation = true
       //let center = CLLocationCoordinate2D(latitude: 52.04, longitude: -0.672)
        //TODO: this produces a bug where user has to tap share location twice to see map
        let center = CLLocationCoordinate2D(latitude: 52.04 , longitude: -0.672 )
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        
        map.region = region
        manager.requestWhenInUseAuthorization()
        
        
        // Show artwork on map
               let artwork = Artwork(
                 title: "King David Kalakaua",
                 locationName: "Waikiki Gateway Park",
                 discipline: "Sculpture",
                 coordinate: CLLocationCoordinate2D(latitude: 52.045561, longitude: -0.675869))
               //mapView.addAnnotation(artwork)
               map.addAnnotation(artwork)
        
        
        
        return map
    }
    
    
    //FUNCTION
    func updateUIView(_ uiView: MKMapView, context: UIViewRepresentableContext<mapView>) {
        
        for i in geopoints {
            
            if i.key != name {
                
                
                let point = MKPointAnnotation()
                point.coordinate = CLLocationCoordinate2D(latitude: i.value.latitude, longitude: i.value.longitude)
                point.title = i.key
                uiView.removeAnnotations(uiView.annotations)
                uiView.addAnnotation(point)
                
            }
        
        }
        
    }
    
    //CLASS
    //coordinator is the delegate of the map view, which means when something interesting happens it gets notified.
    class Coordinator : NSObject, CLLocationManagerDelegate, MKMapViewDelegate {
        
        static var latitude:CLLocationDegrees? = 0.000
        static var longitude:CLLocationDegrees? = 0.000

        //reference to the parent struct so it can pass data back up to SwiftUI
        var parent : mapView
        init(parent1 : mapView) {
            self.parent = parent1
        }
        
        //FUNCTION
        func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
            
            if status == .denied {
                
                print("denied")
            }
            if status == .authorizedWhenInUse{
                
                
                print("authorized")
            }
        }
        
        //FUNCTION
        func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            
            let last = locations.last
            
            let db = Firestore.firestore()
            
            db.collection("locations").document("sharing").setData(["updates" : [self.parent.name :
                GeoPoint(latitude: (last?.coordinate.latitude)!, longitude: (last?.coordinate.longitude)!)]], merge: true)
            {   (err) in
                
                if err != nil{
                    
                    print((err?.localizedDescription)!)
                    return
                }
                
                //print(last?.coordinate.latitude)
                //print(last?.coordinate.longitude)
                
                //TODO: Crashes program for the centre coords
                //mapView.Coordinator.self.longitude = last?.coordinate.longitude
                //mapView.Coordinator.self.latitude = last?.coordinate.latitude
                
                        }
    }
        
        
        func mapView_return_MKAnnotationView( _ mapView: MKMapView, viewFor annotation: MKAnnotation ) -> MKAnnotationView? {
               // 2
               guard let annotation = annotation as? Artwork else {
                 return nil
               }
               // 3
               let identifier = "artwork"
               var view: MKMarkerAnnotationView
               // 4
               if let dequeuedView = mapView.dequeueReusableAnnotationView(
                 withIdentifier: identifier) as? MKMarkerAnnotationView {
                 dequeuedView.annotation = annotation
                 view = dequeuedView
               } else {
                 // 5
                 view = MKMarkerAnnotationView(
                   annotation: annotation,
                   reuseIdentifier: identifier)
                 view.canShowCallout = true
                 view.calloutOffset = CGPoint(x: -5, y: 5)
                 view.rightCalloutAccessoryView = UIButton(type: .detailDisclosure)
               }
               return view
             }
        
        
        
        func mapView_return_MKAnnotationView( _ mapView: MKMapView, annotationView view: MKAnnotationView, calloutAccessoryControlTapped control: UIControl) {
          
            guard let artwork = view.annotation as? Artwork else {
            return
          }

          let launchOptions = [ MKLaunchOptionsDirectionsModeKey: MKLaunchOptionsDirectionsModeDriving]
          artwork.mapItem?.openInMaps(launchOptions: launchOptions)
        }

    
        
}

}





//CLASS
class observer : ObservableObject {
    
    @Published var data = [String:Any]()
    
    init(){
        
        let db = Firestore.firestore()
        
        db.collection("locations").document("sharing").addSnapshotListener{ (snap, err)
                in
            if err != nil {
                print ((err?.localizedDescription)!)
                
                return
    }
            
            let updates = snap?.get("updates") as! [String:GeoPoint]
            
            self.data["data"]  = updates
        }
    }
}
