//
//  AuthView.swift
//  UniversityPal
//
//  Created by Amitesh Nagarkar on 04/05/2020.
//  Copyright © 2020 Amitesh Nagarkar. All rights reserved.
//

//Sign In View

import SwiftUI

//using @state to watch the property for changes
struct SignInView: View{
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    //@environmentobject will let me share variable 'session' of type 'StoreSession' anywhere.
    @EnvironmentObject var session: StoreSession
    
    //this function is only checking & storing the sign info
    //TODO: make this func go to SignUpView struct in SignUp.swift file after self....??
    func signIn(){
        session.signIn(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    var body: some View {
        VStack {
            Text("UniPal Sign in Portal")
                .font(.system(size: 32, weight: .heavy))
            
            Text ("Sign in to continue")
                .font(.system(size:18, weight: .medium))
            .foregroundColor(Color("Gray"))
            
            VStack(spacing:18){
                TextField("Email address", text: $email)
                    .font(.system(size:14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("bg1"),
                        lineWidth: 1))
                
                SecureField("Password", text: $password)
                 .font(.system(size:14))
                    .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("bg1"),
                        lineWidth: 1))
                
            }
            .padding(.vertical,64)
            
            
            Button(action: signIn) {
                Text("Sign in")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.purple), Color(.clear)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
                
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()
            
            NavigationLink(destination: SigningUpView()) {
                HStack {
                    Text("I am a new user")
                        .font (.system(size: 14, weight: .light))
                        .foregroundColor(.primary)
                    
                    Text("Create an account")
                        .font(.system(size: 14, weight: .semibold))
                        .foregroundColor(Color (.purple))
                }
            }
                
            }
            .padding(.horizontal,32)
        }
    }

struct SigningUpView: View {
    @State var email: String = ""
    @State var password: String = ""
    @State var error: String = ""
    @EnvironmentObject var session: StoreSession
    
    
    //TODO: this function also just checks if email and password correct etc but doesnt direct??
    func signUp() {
        session.signUp(email: email, password: password) { (result, error) in
            if let error = error {
                self.error = error.localizedDescription
            } else {
                self.email = ""
                self.password = ""
            }
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Create Account")
                .font(.system(size: 32, weight: .heavy))
                .foregroundColor(Color(.purple))
            
            Text("Sign Up to get started")
            .font(.system(size: 18, weight: .medium))
                .foregroundColor(Color(.purple))
            
            VStack(spacing:18) {
                
                TextField("Email address", text: $email)
                .font(.system(size: 14))
                .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("bg1"),
                        lineWidth: 1))
                
                SecureField("Password", text: $password)
                .font(.system(size: 14))
                .padding(12)
                    .background(RoundedRectangle(cornerRadius: 5).strokeBorder(Color("bg1"),
                        lineWidth: 1))
            } .padding(.vertical, 64)
            
            Button(action: signUp){
                Text("Create Account")
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .frame(height: 50)
                    .foregroundColor(.white)
                    .font(.system(size: 14, weight: .bold))
                    .background(LinearGradient(gradient: Gradient(colors: [Color(.purple), Color(.clear)]), startPoint: .leading, endPoint: .trailing))
                .cornerRadius(5)
            }
            
            if (error != "") {
                Text(error)
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(.red)
                    .padding()
            }
            
            Spacer()

            
        }.padding(.horizontal, 32)
        
        
        
    }
}
 

struct AuthView: View {
    var body: some View{
        NavigationView{
            //SigningUpView()
            SignInView()
        }
    }
}


struct AuthView_Previews: PreviewProvider{
    static var previews: some View {
        AuthView().environmentObject(StoreSession())
    }
    
}
