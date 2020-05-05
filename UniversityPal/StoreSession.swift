//
//  StoreSession.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 04/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

import SwiftUI
import Firebase
import Combine

//this .swift file is for storing/manipulating data

//the 'observableobject'tells swiftui to watch this class for any change annoucements
//we want other things to be able to monitor this for changes
class StoreSession: ObservableObject {
    //'passthroughsubject' is a publisher where it relays values directly to its subscribers without remembering the "current" value:
    var didChange = PassthroughSubject<StoreSession, Never>()
    // "published"; any views using this class get updated when they change
    @Published var session: User? {didSet {self.didChange.send(self) }}
    var handle: AuthStateDidChangeListenerHandle?
    
    func listen() {
        //completion handler will get called whenever the user's authentication state changes
        handle = Auth.auth().addStateDidChangeListener({ (auth, user) in
            if let user = user {
                self.session = User (uid: user.uid, email: user.email)
            } else {
                self.session = nil
            }
            })
    }
    
    //the '@escaping' means the handler is getting stored & not for immediate use.
    func signUp(email:String, password:String, handler: @escaping AuthDataResultCallback) {
        Auth.auth().createUser(withEmail: email, password: password, completion: handler)
    }
    
 func signIn(email:String, password:String, handler: @escaping AuthDataResultCallback) {
     Auth.auth().signIn(withEmail: email, password: password, completion: handler)
 }

    func signOut() {
        do {
            try Auth.auth().signOut()
            self.session = nil
        } catch {
            print ("Error Signing out")
        }
    }
    
    func unbind() {
        if let handle = handle {
            Auth.auth().removeStateDidChangeListener(handle)
        }
    }
    
    //de-allocation
    deinit {
        unbind()
    }
}
    
    
    
struct User {
    var uid: String
    var email: String?
    
    //intialising
    init(uid:String,email: String?) {
        self.uid = uid
        self.email = email
    }
}


struct StoreSession_Previews: PreviewProvider {
    static var previews: some View {
        /*@START_MENU_TOKEN@*/Text("Hello, World!")/*@END_MENU_TOKEN@*/
    }
}
