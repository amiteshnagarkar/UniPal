//
//  Home.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 08/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import Foundation
import SwiftUI
import CoreLocation

struct Home: View {
    @State private var centerCoordinate = CLLocationCoordinate2D()
    var body: some View {
        
        VStack {
            
            //Image("logonew")
            //EmptyView()
            //Spacer()
                //.frame(height: 300)
            MapView(centerCoordinate: $centerCoordinate)
           // Text ("Hi")
                //.frame(width: 400, height: 390)
                
            //Spacer()
            
            HStack{
            Button(action: {
                // your action here
            }) {
                Text("Buyer")
            }
            Button(action: {
                // your action here
            }) {
                Text("Seller")
            }
            .padding()
            }
            //.frame(minWidth: 20, maxWidth: 20, minHeight: 20, maxHeight: 20, alignment: .topLeading)
        
            Spacer()
            .frame(height: 350)
    }
    
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
