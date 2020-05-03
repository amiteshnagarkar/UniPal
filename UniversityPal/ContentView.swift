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
        
        ZStack{
            Color(#colorLiteral(red: 0.3605145216, green: 0.3163693547, blue: 0.8708179593, alpha: 1))
                .edgesIgnoringSafeArea(.all)
            
            VStack {
            VStack (alignment: .center){
            Image ("logo")
                .resizable()
                .aspectRatio( contentMode: .fit)
                .frame(width: 200, height: 200)
                //.padding(130)
                
                }
           
            VStack {
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
                Text("Login")
                .padding()
                
            }
            Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/) {
            Text("Sign Up")
                .padding()
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
