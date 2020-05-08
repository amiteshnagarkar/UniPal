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
            MapView()
                .frame(height:300)
        }
    }
}


struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
