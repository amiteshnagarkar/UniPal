//
//  ContentView.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 03/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        
        //TODO: Need to fix the constraints from splash to initial screen.
        ZStack {
            Color(#colorLiteral(red: 0.3605145216, green: 0.3163693547, blue: 0.8708179593, alpha: 1)) .edgesIgnoringSafeArea(.all)
            
            VStack {
                VStack {
            Image ("logo")
                .resizable()
                //.aspectRatio( contentMode: .fit)
                //.padding(.horizontal, 87.0)
                //.padding(.top, 200)
                .frame(width: 200, height: 200)
                
                
                }
                
           
            VStack { Button(action:) {
                Text("Login")
                .padding()
                .font(.system(size: 28))
                //.padding(.top, 75)
                
            }
                
                }
            }
           
            
            }
                        }

                            }





struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
