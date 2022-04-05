//
//  ContentView.swift
//  LoginWithHash
//
//  Created by Furkan Yıldırım on 4.04.2022.
//

import SwiftUI

struct ContentView: View {
    
    @State private var isItLogin = true

    @State var username: String = ""
    @State var password: String = ""
    
    @State var user: User = User(password: "", capacity: 512)
    
    var body: some View {
        VStack {
            
            Spacer()
            
            HStack {
                Spacer()
                
                Button {
                    if !isItLogin {
                        self.isItLogin.toggle()
                    }
                } label: {
                    ZStack {
                        Text("Login")
                            .foregroundColor(isItLogin ? Color.black : Color.gray)
                            .padding(.vertical, 10)
                        
                        if isItLogin {
                            CustomDivider(width: 100, height: 5)
                        }
                    }
                    .frame(width: 100, height: 60)
                }
                
                Spacer()
                
                Button {
                    if isItLogin {
                        self.isItLogin.toggle()
                    }
                } label: {
                    ZStack {
                        Text("Sign Up")
                            .foregroundColor(!isItLogin ? Color.black : Color.gray)
                            .padding(.vertical, 10)
                        
                        if !isItLogin {
                            CustomDivider(width: 100, height: 5)
                        }
                    }
                    .frame(width: 100, height: 60)
                }
                
                Spacer()
            }
            .font(.system(size: 18))
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 40)
            
            Spacer()
            
            FloatingLabelInput(placeholder: "Username", text: $username)
            FloatingLabelInput(placeholder: "Password", text: $password)
            
            Spacer()
            if isItLogin {
                
                Button {
                    login()
                } label: {
                    Text("Login")
                        .redStyleClassButtonTextStyles()
                }
            }
            else if !isItLogin {
                
                Button {
                    signup()
                } label: {
                    Text("Sign Up")
                        .redStyleClassButtonTextStyles()
                }
            }
        }
        .padding(.horizontal, 20)
    }
    
    func signup() {
        
        self.user.password = self.password
        
        print("\nUsername: " + username + "\nPassword: " + password)
        
        
        var hasher = Hasher()
        hasher.combine(password)
        user.password = String(hasher.finalize())
        
        print("\nUsername: " + username + "\nPassword: " + user.password)

        UserDefaults.standard.set(username, forKey: "Username")
        UserDefaults.standard.set(self.user.password, forKey: "Password")

    }
    
    func login() {
                
        var hasher = Hasher()
        hasher.combine(password)
        user.password = String(hasher.finalize())
        
        print(user.password)
        print(UserDefaults.standard.string(forKey: "Password") ?? "")
        
        if UserDefaults.standard.string(forKey: "Username") == self.username {
            if UserDefaults.standard.string(forKey: "Password") == user.password {
                print("LOGIN")
            }
        }
    }
}

struct User: Hashable {
    var password: String
    var capacity: Int
}
