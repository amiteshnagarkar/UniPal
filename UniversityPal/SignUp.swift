//
//  SignUp.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 06/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import Foundation
import SwiftUI
import Firebase
//my contentview file
import SwiftUI


struct SignUpView: View{
    @EnvironmentObject var session: StoreSession
    
    func getUser() {
        session.listen()
    }
    
    var body:some View{
    Group {
        if (session.session != nil) {
            Text ("Welcome back")
            Button(action: session.signOut) {
                    Text("Sign Out")
            }
            
            
            Button(action: sendEmail){
                Text("Send Verification Email")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.purple), Color(.clear)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
            }
            
          NavigationView {
                    VStack {
                            /*Text("Enter Home")
                                .frame(minWidth: 0, maxWidth: .infinity)
                                .frame(height: 50)
                                .foregroundColor(.white)
                                .font(.system(size: 14, weight: .bold))
                                .background(LinearGradient(gradient: Gradient(colors: [Color(.purple), Color(.clear)]), startPoint: .leading, endPoint: .trailing))
                            .cornerRadius(5) */
                                NavigationLink(destination: Home()) {
                                //Text("Enter Home")
                                    Text("Do Something")
                                    
                                
                        }
                    }
                }
        
            
            
            
    }   else {
            AuthView()
            }
        }.onAppear(perform: getUser)
    }
}


func sendEmail() {
    //Text("tesst")
    //TODO: add extra checks and remove the yellow error below..
    let user = Auth.auth().currentUser
    Auth.auth().currentUser?.sendEmailVerification { (error) in
          
            print ("hi")
          }
          // [END_EXCLUDE]
        }
        // [END send_verification_email]
      
    

    


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View{
        SignUpView().environmentObject(StoreSession())
    }
}

