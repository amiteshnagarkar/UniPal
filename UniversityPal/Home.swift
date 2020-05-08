//
//  Home.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 08/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import Foundation
import SwiftUI

struct Home: View {
    var body: some View {
        VStack {
            //Image("logonew")
            //EmptyView()
            Spacer()
                .frame(height: 5)
            MapView()
           // Text ("Hi")
                .frame(width: 400, height: 390)
            Spacer()
        } //.frame(minWidth: 20, maxWidth: 20, minHeight: 20, maxHeight: 20, alignment: .topLeading)
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
