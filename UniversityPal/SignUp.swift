//
//  SignUp.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 04/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

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
    }   else {
            Text("Show Auth Screen")
            }
        }.onAppear(perform: getUser)
    }
}


struct SignUpView_Previews: PreviewProvider {
    static var previews: some View{
        SignUpView().environmentObject(StoreSession())
    }
}

